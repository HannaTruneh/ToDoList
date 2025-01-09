

import SwiftUI

struct EditToDoView: View {
    @Bindable var todo: ToDo
    
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
}

#Preview {
    EditToDoView(todo: ToDo(title:"", details:"", deadline: Date()))
}

