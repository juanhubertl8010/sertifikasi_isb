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
    @Published var updatingIds: Set<UUID> = []
    
    private let client = SupabaseService.shared.client
    
    func fetchBorrowings() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let borrowings: [Borrowing] = try await client
                .from("borrowings")
                .select("""
                    id,
                    borrow_date,
                    return_date,
                    participant:participants(id,name,email),
                    collection:collection_id(id,title,author,available)
                """)
                .execute()
                .value
            
            print("✅ Borrowings count:", borrowings.count)
            
            self.borrowings = borrowings
            
        } catch {
            print("❌ FETCH BORROWINGS ERROR:", error)
        }
    }
    func returnBook(borrowing: Borrowing) async {
        updatingIds.insert(borrowing.id)
        defer { updatingIds.remove(borrowing.id) }
        
        do {
            let now = ISO8601DateFormatter().string(from: Date())
            
            // 1️⃣ Update borrowings.return_date
            try await client
                .from("borrowings")
                .update([
                    "return_date": now
                ])
                .eq("id", value: borrowing.id.uuidString)
                .execute()
            
            // 2️⃣ Update collections.available = true
            try await client
                .from("collections")
                .update([
                    "available": true
                ])
                .eq("id", value: borrowing.collection.id.uuidString)
                .execute()
            
            // 3️⃣ Update UI lokal
            if let index = borrowings.firstIndex(where: { $0.id == borrowing.id }) {
                let updatedCollection = Collection(
                    id: borrowing.collection.id,
                    title: borrowing.collection.title,
                    author: borrowing.collection.author,
                    available: true // 🔑 pastikan available diubah
                )
                
                borrowings[index] = Borrowing(
                    id: borrowing.id,
                    borrowDateRaw: borrowing.borrowDateRaw,
                    returnDateRaw: now,
                    participant: borrowing.participant,
                    collection: updatedCollection
                )
            }
            
            print("✅ Returned:", borrowing.collection.title)
            
        } catch {
            print("❌ RETURN BOOK ERROR")
            dump(error)
        }
    }
}
