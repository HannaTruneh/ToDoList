import SwiftUI

struct AddView: View {
    
    @ObservedObject var viewModel: ListViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var details = ""
    @State private var deadline = Date()
    
    var isSaveButtonEnabled: Bool {
        !title.isEmpty 
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
    AddView(viewModel: ListViewModel())
}
