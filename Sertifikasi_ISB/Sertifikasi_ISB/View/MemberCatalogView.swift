import SwiftUI

struct MemberCatalogView: View {

    let participant: Participant
    @ObservedObject var authVM: AuthViewModel
    @StateObject private var vm = CatalogViewModel()

    var body: some View {
        List(vm.collections) { item in
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .font(.headline)
                    
                    Text(item.author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(item.available ? "Available" : "On Loan")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(item.available ? Color.green : Color.red)
                    .cornerRadius(8)
                    .shadow(
                        color: (item.available ? Color.green : Color.red).opacity(0.4),
                        radius: 6,
                        x: 0,
                        y: 3
                    )

            }
            .contentShape(Rectangle())
            .onTapGesture {
                guard item.available else { return }

                Task {
                    await vm.borrowCollection(
                        item,
                        by: participant.id
                    )
                }
            }
        }
        .overlay {
            if vm.isLoading {
                ProgressView()
            }
        }
        .task {
            await vm.fetchCollections()
        }
        .navigationTitle("Book Catalog")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(role: .destructive) {
                    authVM.logout()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }

        }
    
}
