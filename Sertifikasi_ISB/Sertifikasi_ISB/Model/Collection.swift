//
//  Collection.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import Foundation

struct Collection: Identifiable, Decodable {
    let id: UUID
    let title: String
    let author: String
    var available: Bool
}
