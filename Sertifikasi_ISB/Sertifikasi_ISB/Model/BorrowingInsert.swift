import Foundation

struct BorrowingInsert: Encodable {
    let participant_id: UUID
    let collection_id: UUID
    let borrow_date: Date
    let return_date: Date
}
