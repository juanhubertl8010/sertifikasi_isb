//
//  EmployeeViewModel.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import Foundation
import Supabase
import Combine

@MainActor
final class EmployeeViewModel: ObservableObject {

    @Published var borrowings: [Borrowing] = []
    @Published var isLoading: Bool = false   // ⬅️ HARUS Bool, BUKAN Optional

    private let client = SupabaseService.shared.client

    func fetchBorrowings() async {
        isLoading = true
        defer { isLoading = false }

        do {
            borrowings = try await client
                .from("borrowings")
                .select("""
                    id,
                    borrow_date,
                    return_date,
                    participant:participants(id,name,email),
                    collection:collections(id,title,author)
                """)
                .execute()
                .value
        } catch {
            print(error)
        }
    }
}

