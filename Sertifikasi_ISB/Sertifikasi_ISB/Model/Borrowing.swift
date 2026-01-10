//
//  Borrowing.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import Foundation

struct Borrowing: Identifiable, Decodable {

    let id: UUID
    let borrowDateRaw: String
    let returnDateRaw: String?
    let participant: Participant
    let collection: Collection

    enum CodingKeys: String, CodingKey {
        case id
        case borrowDateRaw = "borrow_date"
        case returnDateRaw = "return_date"
        case participant
        case collection
    }

    /// Tanggal pinjam (hasil parse ISO8601)
    var borrowDate: Date {
        ISO8601DateFormatter().date(from: borrowDateRaw) ?? Date()
    }

    /// Tanggal kembali (default = +7 hari dari borrowDate)
    var returnDate: Date {
        if let raw = returnDateRaw,
           let parsed = ISO8601DateFormatter().date(from: raw) {
            return parsed
        }

        return Calendar.current.date(
            byAdding: .day,
            value: 7,
            to: borrowDate
        )!
    }
}

