//
//  SupabaseService.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import Supabase
import Foundation

final class SupabaseService {
    static let shared = SupabaseService()

    let client: SupabaseClient

    private init() {
        client = SupabaseClient(
            supabaseURL: URL(string: "https://rapefdudlcdvmogdlesg.supabase.co")!,
            supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJhcGVmZHVkbGNkdm1vZ2RsZXNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc3ODQ5MjUsImV4cCI6MjA4MzM2MDkyNX0.FFQXEseXVZ-173bjBm5XQSkPhZTX47p42Bb5btPYGqk"
        )
    }
}
