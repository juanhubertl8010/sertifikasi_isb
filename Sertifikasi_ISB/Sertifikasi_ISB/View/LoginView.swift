import SwiftUI

struct LoginView: View {
    
    @ObservedObject var vm: AuthViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            
            Text("PERPUSKU")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 24)
            
            TextField("Email", text: $vm.email)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            
            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)
            
            Button {
                Task { await vm.login() }
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
