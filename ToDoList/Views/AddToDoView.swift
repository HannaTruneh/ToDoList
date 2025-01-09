import SwiftUI
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
                    
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Button("Save") {
                    let newTodo = ToDo(title: title, details: details, deadline: deadline)
                    viewModel.addNewToDo(newTodo: newTodo)
                    dismiss() // חזרה למסך הקודם
                }
            }
            .navigationTitle("Add New Todo")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddToDoView(viewModel: ToDoListViewModel())
}
