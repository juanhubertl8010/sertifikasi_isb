//
//  CatalogViewModel.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import Foundation
import Supabase
import Combine
// MARK: - ViewModel
@MainActor
final class CatalogViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published private(set) var collections: [Collection] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies
    private let client = SupabaseService.shared.client

    // MARK: - Public Methods
    func fetchCollections() async {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            collections = try await client
                .from("collections")
                .select()
                .order("title", ascending: true)
                .execute()
                .value
        } catch {
            errorMessage = error.localizedDescription
            print("Fetch collections error:", error)
        }
    }

    func borrowCollection(
        _ collection: Collection,
        by participantID: UUID
    ) async {
        guard collection.available else { return }

        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        let borrowDate = Date()
        let returnDate = Calendar.current.date(byAdding: .day, value: 7, to: borrowDate)!

        let payload = BorrowingInsert(
            participant_id: participantID,
            collection_id: collection.id,
            borrow_date: borrowDate,
            return_date: returnDate
        )

        do {
            try await insertBorrowing(payload)
            try await updateCollectionAvailability(
                collectionID: collection.id,
                available: false
            )
            await fetchCollections()
        } catch {
            errorMessage = error.localizedDescription
            print("Borrow collection error:", error)
        }
    }
}

// MARK: - Private Helpers
private extension CatalogViewModel {

    func insertBorrowing(_ payload: BorrowingInsert) async throws {
        try await client
            .from("borrowings")
            .insert(payload)
            .execute()
    }

    func updateCollectionAvailability(
        collectionID: UUID,
        available: Bool
    ) async throws {
        try await client
            .from("collections")
            .update(["available": available])
            .eq("id", value: collectionID)
            .execute()
    }
}
