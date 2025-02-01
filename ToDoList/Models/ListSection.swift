import Foundation


class ListSection: ObservableObject {
    var name: String
    var todos: [ToDo]
    
    init(name: String, todos: [ToDo]) {
        self.name = name
        self.todos = todos
    }
}


