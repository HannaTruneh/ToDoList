import SwiftUI

struct AddToDoView: View {
    
    @ObservedObject var viewModel: ToDoListViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var details = ""
    @State private var deadline = Date()
    
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
                }
            }
            .navigationTitle("Add New Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func saveAction() {
        let newTodo = ToDo(id: UUID().uuidString, title: title, details: details, deadline: deadline)
        viewModel.createTodo(newTodo: newTodo)
        dismiss()
    }
}

#Preview {
    AddToDoView(viewModel: ToDoListViewModel())
}
