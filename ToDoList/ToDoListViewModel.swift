import Foundation
import SwiftData
import SwiftUICore



class ToDoListViewModel: ObservableObject {
    @Published var todos: [ToDo] = []
    
    @Environment(\.modelContext) private var modelContext
    
    func addNewToDo(title: String, deadline: Date) {
        let newToDo = ToDo(title: title, deadline: deadline)
        //        try? modelContext.insert(newToDo)
        todos.append(newToDo)
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        _ = todos[index]
        //        try? modelContext.delete(toDoToDelete)
        todos.remove(at: index)
    }
    
}
