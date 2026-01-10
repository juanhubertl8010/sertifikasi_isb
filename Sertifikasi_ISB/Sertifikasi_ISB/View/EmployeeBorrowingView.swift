import SwiftUI

struct EmployeeBorrowingView: View {

    @StateObject private var vm = EmployeeViewModel()
    @ObservedObject var authVM: AuthViewModel
    var body: some View {

        ScrollView(.horizontal) {
            VStack(spacing: 0) {

                
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

             
                ScrollView(.vertical) {
                    LazyVStack(spacing: 0) {
                        ForEach(vm.borrowings) { item in
                            let isAvailable = item.collection.available
                            let isUpdating = vm.updatingIds.contains(item.id)

                            HStack {

                               
                                Text(item.collection.title)
                                    .frame(width: 250, alignment: .leading)
                                    .font(.subheadline)
                                    .lineLimit(1)

                                
                                Text(item.participant.name)
                                    .frame(width: 140, alignment: .leading)
                                    .font(.caption)
                                    .lineLimit(1)

                                
                                Text(item.borrowDate.formatted(date: .numeric, time: .omitted))
                                    .frame(width: 100)
                                    .font(.caption)

                             
                                Text(item.returnDate.formatted(date: .numeric, time: .omitted))
                                    .frame(width: 100)
                                    .font(.caption)

                            
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
                                .background(isAvailable ? Color.gray : Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(6)
                                .disabled(isAvailable || isUpdating) 
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
        .navigationTitle("Borrowing List")
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
