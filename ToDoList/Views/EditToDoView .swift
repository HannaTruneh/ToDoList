import SwiftUI

struct EditToDoView: View {
    
    @StateObject private var viewModel = ToDoListViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State var todo: ToDo
    @State private var title = ""
    @State private var details = ""
    @State private var deadline = Date()
    
    
    var body: some View {
        Form {
            Section {
                TextField("Todo", text: $todo.title)
                
                TextField("Details", text: $todo.details, axis: .vertical)
                
                
                DatePicker("Deadline", selection: $todo.deadline, displayedComponents: [.date, .hourAndMinute])
            }
        }
        .navigationTitle("Edit Todo")
        .navigationBarTitleDisplayMode(.inline)
        
    }

    func saveAction() {
        let newTodo = ToDo(id: UUID().uuidString, title: title, details: details, deadline: deadline)
        viewModel.addNewTodo(newTodo: newTodo)
        dismiss()
    }
}

#Preview {
    EditToDoView(todo: ToDo(id: "", title:"", details:"", deadline: Date()))
}

