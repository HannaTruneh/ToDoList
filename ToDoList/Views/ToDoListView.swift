import SwiftUI
import SwiftData

struct ToDoListView: View {
    
    @StateObject private var viewModel = ToDoListViewModel()
    @State var newTodo: ToDo? = nil
    @State var newTodoTitle = ""
    @State var details = ""
    @State var newTodoDeadline = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                List($viewModel.todos, id: \.self, editActions: .delete) { $todo in
                    NavigationLink(destination: EditToDoView(todo: todo)) {
                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .font(.headline)
                            Text("Deadline: \(String.formattedDate(todo.deadline))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("To-Do List")
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
    
    func saveAction(_ todo: ToDo) {
        viewModel.addNewToDo(newTodo: todo)
        newTodo = nil
        newTodoTitle = ""
        newTodoDeadline = Date()
        details = ""
    }
}
//
//    private func deleteToDo(at offsets: IndexSet) {
//        viewModel.deleteToDo(at: offsets)
//    }
//}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true)
        .environmentObject(ToDoSections(id: UUID(), name: "hi", numbersOfTodos: 1, todos: [ToDo(title: "Test", details: "Testies", deadline: Date())]))
}

extension String {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
