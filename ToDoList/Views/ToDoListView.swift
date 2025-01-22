import SwiftUI


struct ToDoListView: View {
    
    @StateObject private var viewModel = ToDoListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        ForEach (viewModel.todos, id: \.id) { todo in
                            NavigationLink(destination: EditToDoView(todo: todo)) {
                                VStack(alignment: .leading) {
                                    Text(todo.title ?? "")
                                        .font(.headline)
                                    
                                    Text("Deadline: \(String.formattedDate(todo.deadline ?? Date()))")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let todo = viewModel.todos[index]
                                viewModel.deleteTodo(id: todo.id ?? "")
                            }
                        }
                    }
                    .padding(.bottom)
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
                    NavigationLink(destination: AddToDoView(viewModel: viewModel)) {
                        Label("Add Todo", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                    
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
}

extension String {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
