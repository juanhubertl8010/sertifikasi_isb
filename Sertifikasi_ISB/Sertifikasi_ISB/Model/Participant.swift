//
//  Participant.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import Foundation

struct Participant: Identifiable, Decodable {
    let id: UUID
    let name: String
    let email: String
    let role: String?       
    let createdAt: Date?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case role
        case createdAt = "created_at"
    }
}

