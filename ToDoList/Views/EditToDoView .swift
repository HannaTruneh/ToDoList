import SwiftUI

struct EditToDoView: View {
    
    @StateObject private var viewModel = ToDoListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @Binding var todo: ToDo
    
    @State private var title = ""
    @State private var details = ""
    @State private var deadline = Date()
    
    init(todo: ToDo) {
            self._todo = Binding(get: { todo }, set: { _ in })
            self._title = State(initialValue: todo.title ?? "")
            self._details = State(initialValue: todo.details ?? "")
            self._deadline = State(initialValue: todo.deadline ?? Date())
        }
    
    var isSaveButtonEnabled: Bool {
        todo.title != title || todo.details != details || todo.deadline != deadline
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Todo", text: $title)
                    
                    TextField("Details", text: $details, axis: .vertical)
                }
                
                Section {
                    
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAction()
                    }
                    .disabled(!isSaveButtonEnabled)
                }
            }
            .navigationTitle("Edit Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func saveAction() {
        todo.title = title
        todo.details = details
        todo.deadline = deadline
        viewModel.updateTodo(todo: todo)
        dismiss()
    }
}

#Preview {
    EditToDoView(todo: ToDo(id: "", title:"", details:"", deadline: Date()))
}
                 

