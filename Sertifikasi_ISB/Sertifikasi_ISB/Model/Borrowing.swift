import Foundation

struct Borrowing: Identifiable, Decodable {

    let id: UUID
    let borrowDate: Date
    let returnDate: Date
    let participant: Participant
    let collection: Collection

    enum CodingKeys: String, CodingKey {
        case id
        case borrowDate = "borrow_date"
        case returnDate = "return_date"
        case participant
        case collection
    }
}
