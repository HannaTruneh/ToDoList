import SwiftUI


struct ListView: View {
    
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                else if viewModel.todos.isEmpty {
                    NoTodosView(viewModel: viewModel)
                    
                } else {
                    
                    List {
                        ForEach (viewModel.todos, id: \.id) { todo in
                            NavigationLink(destination: EditView(todo: todo)) {
                                ListRowView(todo: todo)
                                    .onTapGesture {
                                        Task {
                                            viewModel.updateCompletion(todo: todo)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listStyle(PlainListStyle())
                            .opacity(1)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let todo = viewModel.todos[index]
                                viewModel.deleteTodo(id: todo.id)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color("background"))
                }
            }
            .navigationTitle("To-Do List")
            .onAppear {
                Task {
                    viewModel.getTodos()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AddView(viewModel: viewModel)) {
                        Label("Add Todo", systemImage: "plus")
                            .imageScale(.large)
                            .scaleEffect(3)
                    }
                }
            }
        }
    }
}


#Preview {
    ListView()
}

extension String {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
