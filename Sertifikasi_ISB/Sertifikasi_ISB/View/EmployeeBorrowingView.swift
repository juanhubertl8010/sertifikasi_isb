import SwiftUI

struct EmployeeBorrowingView: View {

    @StateObject private var vm = EmployeeViewModel()

    var body: some View {

        ScrollView(.horizontal) {
            VStack(spacing: 0) {

                // 🧾 HEADER
                HStack {
                    Text("Title").frame(width: 250, alignment: .leading)
                    Text("Member").frame(width: 140, alignment: .leading)
                    Text("Borrow").frame(width: 100)
                    Text("Return").frame(width: 100)
                    Text("").frame(width: 120)
                }
                .font(.caption.bold())
                .padding()
                .background(Color(.systemGray6))

                Divider()

                // 📋 VERTICAL SCROLL
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.borrowings) { item in
                            let isAvailable = item.collection.available
                            let isUpdating = vm.updatingIds.contains(item.id)

                            HStack {

                                // 📚 Title
                                Text(item.collection.title)
                                    .frame(width: 250, alignment: .leading)
                                    .font(.subheadline)
                                    .lineLimit(1)

                                // 👤 Member
                                Text(item.participant.name)
                                    .frame(width: 140, alignment: .leading)
                                    .font(.caption)
                                    .lineLimit(1)

                                // 📅 Borrow
                                Text(item.borrowDate.formatted(date: .numeric, time: .omitted))
                                    .frame(width: 100)
                                    .font(.caption)

                                // 📅 Return
                                Text(item.returnDate.formatted(date: .numeric, time: .omitted))
                                    .frame(width: 100)
                                    .font(.caption)

                                // 🔘 RETURN BUTTON
                                Button {
                                    Task {
                                        await vm.returnBook(borrowing: item)
                                    }
                                } label: {
                                    if isUpdating {
                                        ProgressView()
                                            .scaleEffect(0.7)
                                    } else {
                                        Text("Return")
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .frame(width: 110, height: 32)
                                .contentShape(Rectangle())
                                .buttonStyle(.plain)
                                .background(isAvailable ? Color.gray : Color.green) // 🔑 warna hijau kalau available = false
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .disabled(isAvailable || isUpdating) // 🔑 disable kalau sudah available
                                .opacity(isAvailable ? 0.5 : 1)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)

                            Divider()
                        }
                    }
                }
            }
        }
        .overlay {
            if vm.isLoading {
                ProgressView()
            }
        }
        .task {
            await vm.fetchBorrowings()
        }
        .navigationTitle("Borrowed Books")
    }
}
