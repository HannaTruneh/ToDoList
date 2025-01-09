import Foundation

class ToDoSections: ObservableObject {
    
    let id: UUID
    let name:  String
    var numbersOfTodos: Int
    
    @Published var todos: [ToDo]
    
    init(id: UUID, name: String, numbersOfTodos: Int, todos: [ToDo]) {
        self.id = id
        self.name = name
        self.numbersOfTodos = numbersOfTodos
        self.todos = todos
    }
}
