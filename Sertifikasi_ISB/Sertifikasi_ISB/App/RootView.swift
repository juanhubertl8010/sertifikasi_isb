import SwiftUI

struct RootView: View {

    @StateObject private var authVM = AuthViewModel()

    var body: some View {
        NavigationStack {
            if authVM.isLoggedIn, let participant = authVM.participant {
                switch participant.role {
                case "member":
                    MemberCatalogView(
                        participant: participant,
                        authVM: authVM
                    )

                case "employee":
                    EmployeeBorrowingView(
                        authVM: authVM
                    )

                default:
                    Text("Role tidak dikenal")
                }
            } else {
                LoginView(vm: authVM)
            }
        }
    }
}
