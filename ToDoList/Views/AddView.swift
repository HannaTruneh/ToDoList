import SwiftUI

struct AddView: View {
    
    @ObservedObject var viewModel: ListViewModel
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var title = ""
    @State private var notes = ""
    @State private var dueDate = Date()
    
    var isSaveButtonEnabled: Bool {
        !title.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                        .focused($isTextFieldFocused)
                        .onAppear {
                            isTextFieldFocused = true // Keyboard doesn't appear
                        }
                    
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
                        viewModel.showAddTodoSheet = false
                    }
                    .disabled(!isSaveButtonEnabled)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.showAddTodoSheet = false
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add New Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func saveAction() {
        let newTodo = ToDo(id: UUID().uuidString, title: title, notes: notes, dueDate: dueDate, isCompleted: true)
        viewModel.createTodo(newTodo: newTodo)
        dismiss()
        viewModel.getTodos()
    }
}

#Preview {
    AddView(viewModel: ListViewModel())
}


