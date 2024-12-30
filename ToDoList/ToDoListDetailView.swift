

import SwiftUI


struct ToDoListDetailView: View {
    
    @State private var newTodo = ""
    
    
    var body: some View {
        
        TextField("Add task", text: $newTodo)
            .padding()
        Text(newTodo)
    }
}

#Preview {
    ToDoListDetailView()
}
