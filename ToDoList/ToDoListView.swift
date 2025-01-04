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
                    NavigationLink(value: todo) {
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
                .navigationDestination(for: ToDo.self) { todo in
                    EditToDoView(todo: todo)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            newTodo = ToDo(title: "", details: "", deadline: .now)
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .sheet(item: $newTodo, onDismiss: {
                    newTodoTitle = ""
                    newTodoDeadline = Date()
                }) { todo in
                    VStack(spacing: 20) {
                        Spacer().frame(height: 10)
                        
                        Form {
                            Section {
                                TextField("New Todo", text: $newTodoTitle)
                                
                                TextField("Details", text: $details)

                            }
                            
                            DatePicker("Deadline", selection: $newTodoDeadline, displayedComponents: [.date, .hourAndMinute])
                        }
                        
                        Spacer()
                        
                        SaveButton(text: "Save") {
                            todo.title = newTodoTitle
                            todo.deadline = newTodoDeadline
                            todo.details = details
                            saveAction(todo)
                        }
                        .disabled(newTodoTitle.isEmpty)
                        .opacity(newTodoTitle.isEmpty ? 0.5 : 1.0)
                    }
                    .presentationDetents([.medium, .large])
                    .padding()
                }
            }
        }
    }
    
    func saveAction(_ todo: ToDo) {
        viewModel.addNewToDo(newTodo: todo)
        newTodo = nil
        newTodoTitle = ""
        newTodoDeadline = Date()
    }
    
    private func deleteToDo(at offsets: IndexSet) {
        viewModel.deleteToDo(at: offsets)
    }
}


#Preview {
    ToDoListView()
        .modelContainer(for: ToDo.self, inMemory: true)
}


extension String {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

