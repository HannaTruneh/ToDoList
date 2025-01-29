import Foundation


class ListViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var todos: [ToDo] = []

    
    let firebaseService = FirebaseService()
    
    
    func createTodo(newTodo: ToDo) {
        todos.append(newTodo)
        Task {
            await firebaseService.createTodo(todo: newTodo)
        }
    }
    
    func updateTodo(todo: ToDo) {
        todos.append(todo)
        Task {
            await firebaseService.updateTodo(todo: todo)
        }
    }
    
    func updateCompletion(todo: ToDo) {
        Task {
            await firebaseService.updateCompletion(todo: todo)
            getTodos()
        }
    }
    
    func getTodos() {
        Task {
            if let todosList = await firebaseService.fetchAllTodos() {

                DispatchQueue.main.async {
                    self.todos = todosList
                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }

    
    func deleteTodo(id: String) {
        Task{
            await firebaseService.deleteTodo(id: id)
            getTodos()
        }
    }
}


