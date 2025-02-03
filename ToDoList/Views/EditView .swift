import SwiftUI

struct EditView: View {
    
    @ObservedObject private var viewModel = ListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var todo: ToDo
    
    @State private var title = ""
    @State private var notes = ""
    @State private var dueDate = Date()
    
    init(todo: ToDo) {
        self.todo = todo
    }
    
    var isSaveButtonEnabled: Bool {
        todo.title != title || todo.notes != notes || todo.dueDate != dueDate && !title.isEmpty
    }
    
    var body: some View {
        NavigationStack {
                Form {
                    Section {
                        TextField("Title", text: $title)
                        
                        TextField("Notes", text: $notes, axis: .vertical)
                            .padding(.bottom, 80)
                            .frame(height: 100)
                    }
                    
                    Section {
                        
                        DatePicker("Date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
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
                .onAppear {
                    updateFieldsFromTodo()
                }
                .background(.linearGradient(colors: [Color("background"), Color("pink")], startPoint: .top, endPoint: .bottom))
            }
        }
    
    func updateFieldsFromTodo() {
        title = todo.title ?? ""
        notes = todo.notes ?? ""
        dueDate = todo.dueDate ?? Date()
    }
    
    func saveAction() {
        todo.title = title
        todo.notes = notes
        todo.dueDate = dueDate
        viewModel.updateTodo(todo: todo)
        dismiss()
    }
}

#Preview {
    EditView(todo: ToDo(id: "", title:"", notes:"", dueDate: Date(), isCompleted: true))
}


