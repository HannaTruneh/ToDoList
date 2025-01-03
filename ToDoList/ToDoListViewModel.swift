import Foundation
import SwiftData
import SwiftUICore


class ToDoListViewModel: ObservableObject {
    @Published var todos: [ToDo] = []
    
    @Environment(\.modelContext) private var modelContext
    
    func addNewToDo(newTodo: ToDo) {
        todos.append(newTodo)
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        _ = todos[index]
        todos.remove(at: index)
    }
}
