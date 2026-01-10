import SwiftUI

struct RootView: View {

    @StateObject private var authVM = AuthViewModel()

    var body: some View {
        Group {
            if let participant = authVM.participant {
                switch participant.role {
                case "member":
                    NavigationStack {
                        MemberCatalogView(participant: participant)
                    }

                case "employee":
                    NavigationStack {
                        EmployeeBorrowingView()
                    }

                default:
                    Text("Role tidak dikenal")
                }
            } else {
                LoginView(vm: authVM)
            }
        }
    }
}
