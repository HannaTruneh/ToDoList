import Foundation


class ListSection: ObservableObject {
    let name: String
    let todos: [ToDo]
    
    init(name: String, todos: [ToDo]) {
        self.name = name
        self.todos = todos
    }
}


