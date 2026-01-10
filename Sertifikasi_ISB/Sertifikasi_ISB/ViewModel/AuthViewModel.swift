//
//  AuthViewModel.swift
//  Sertifikasi_ISB
//
//  Created by Juan Hubert Liem on 10/01/26.
//

import SwiftUI
import Combine
import PostgREST
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var participant: Participant?
    @Published var isLoggedIn = false

    func login() async {
        do {
            let auth = try await SupabaseService.shared.client.auth
                .signIn(email: email, password: password)

            let userId = auth.user.id

            let response: Participant = try await SupabaseService.shared.client
                .from("participants")
                .select()
                .eq("id", value: userId)
                .single()
                .execute()
                .value

            self.participant = response
            self.isLoggedIn = true
        } catch {
            print("Login error:", error)
        }
    }
    func createDummyUser(
        email: String,
        password: String,
        name: String,
        role: String
    ) async {
        do {
            // 1. Signup user ke Supabase Auth
            let authResponse = try await SupabaseService.shared.client.auth
                .signUp(email: email, password: password)

            let userId = authResponse.user.id

            // 2. Insert ke tabel participants
            try await SupabaseService.shared.client
                .from("participants")
                .insert([
                    "id": userId.uuidString,
                    "name": name,
                    "email": email,
                    "role": role
                ])
                .execute()

            print("✅ Dummy user created:", email)
        } catch {
            print("❌ Failed create dummy user:", error)
        }
    }
    
}
