import SwiftUI

struct EditToDoView: View {
    @Bindable var todo: ToDo
    
    var body: some View {
        Form {
            Section {
                TextField("Todo", text: $todo.title)
                
                DatePicker("Deadline", selection: $todo.deadline, displayedComponents: [.date, .hourAndMinute])
            }
        }
        .navigationTitle("Edit Todo")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    EditToDoView(todo: )
//}
