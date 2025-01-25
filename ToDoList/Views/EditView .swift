import SwiftUI

struct EditView: View {
    
    @StateObject private var viewModel = ListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var todo: ToDo
    
    @State private var title = ""
    @State private var details = ""
    @State private var deadline = Date()
    
    init(todo: ToDo) {
           self.todo = todo
       }
    
    var isSaveButtonEnabled: Bool {
        todo.title != title || todo.details != details || todo.deadline != deadline && !title.isEmpty
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
            .background(.linearGradient(colors: [Color("background"), Color("pink")], startPoint: .top, endPoint: .bottom))
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
            .onAppear {
                updateFieldsFromTodo()
            }
        }
        
    }
    
    func updateFieldsFromTodo() {
            title = todo.title ?? ""
            details = todo.details ?? ""
            deadline = todo.deadline ?? Date()
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
    EditView(todo: ToDo(id: "", title:"", details:"", deadline: Date()))
}
                 

