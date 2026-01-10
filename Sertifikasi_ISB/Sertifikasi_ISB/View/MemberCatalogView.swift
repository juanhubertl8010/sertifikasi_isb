import SwiftUI

struct MemberCatalogView: View {

    let participant: Participant
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

                Text(item.available ? "Available" : "Borrowed")
                    .font(.caption)
                    .foregroundColor(item.available ? .green : .red)
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
        .navigationTitle("Catalog")
    }
}
