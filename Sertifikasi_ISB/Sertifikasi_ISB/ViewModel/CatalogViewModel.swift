import Foundation
import Supabase
import Combine

@MainActor
final class CatalogViewModel: ObservableObject {

    // MARK: - Published
    @Published var collections: [Collection] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Supabase
    private let client = SupabaseService.shared.client

    // MARK: - Fetch
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
            print("❌ Fetch collections error:", error)
        }
    }

    // MARK: - Borrow
    func borrowCollection(
        _ collection: Collection,
        by participantID: UUID
    ) async {

        guard collection.available else { return }

        // 1️⃣ Optimistic UI update
        guard let index = collections.firstIndex(where: { $0.id == collection.id }) else { return }
        collections[index].available = false

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
            // 2️⃣ Insert borrowing
            try await client
                .from("borrowings")
                .insert(payload)
                .select() // 🔥 WAJIB
                .execute()

            // 3️⃣ Update availability
            try await client
                .from("collections")
                .update(["available": false])
                .eq("id", value: collection.id)
                .select() // 🔥 WAJIB
                .execute()

        } catch {
            // 4️⃣ Rollback UI kalau gagal
            collections[index].available = true
            errorMessage = error.localizedDescription
            print("❌ Borrow error:", error)
        }
    }
}
