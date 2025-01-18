import SwiftUI

struct EditToDoView: View {
    
    @StateObject private var viewModel = ToDoListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State var todo: ToDo
    @State private var title = ""
    @State private var details = ""
    @State private var deadline = Date()
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Todo", text: $todo.title)
                    
                    TextField("Details", text: $todo.details, axis: .vertical)
                }
                
                Section {
                    
                    DatePicker("Deadline", selection: $todo.deadline, displayedComponents: [.date, .hourAndMinute])
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAction()
                    }
                }
            }
            .navigationTitle("Edit Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func saveAction() {
        let todo = ToDo(id: todo.id, title: todo.title, details: todo.details, deadline: todo.deadline)
        viewModel.updateTodo(todo: todo)
        dismiss()
    }
}

#Preview {
    EditToDoView(todo: ToDo(id: "", title:"", details:"", deadline: Date()))
}

