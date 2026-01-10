import SwiftUI

struct EmployeeBorrowingView: View {

    let participant: Participant
    @StateObject private var vm = EmployeeViewModel()

    var body: some View {
        ZStack {
            List(vm.borrowings) { item in
                VStack(alignment: .leading, spacing: 6) {

                    Text(item.collection.title)
                        .font(.headline)

                    Text("Member: \(item.participant.name)")
                        .font(.subheadline)

                    Text("Borrow: \(item.borrowDate.formatted(date: .abbreviated, time: .omitted))")

                    Text("Return: \(item.returnDate.formatted(date: .abbreviated, time: .omitted))")
                }
                .padding(.vertical, 4)
            }

            if vm.isLoading {
                ProgressView()
                    .scaleEffect(1.2)
            }
        }
        .task {
            await vm.fetchBorrowings()
        }
        .navigationTitle("Borrowed Books")
    }
}
