import Foundation


class ListViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var showAddTodoSheet: Bool = false
    @Published var todos: [ToDo] = []
    @Published var pendingTodos: [ToDo] = []
    @Published var completedTodos: [ToDo] = []
    
    let firebaseService = FirebaseService()
    
    
    //    func createTodo(newTodo: ToDo) {
    //        todos.append(newTodo)
    //        Task {
    //            await firebaseService.createTodo(todo: newTodo)
    //        }
    //    }
    
    func createTodo(newTodo: ToDo) {
        DispatchQueue.main.async {
            
            self.pendingTodos.append(newTodo)
        }
        
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
            
            if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                todos[index].isCompleted.toggle()
            }
            
            DispatchQueue.main.async {
                self.pendingTodos = self.todos.filter { !$0.isCompleted }
                self.completedTodos = self.todos.filter { $0.isCompleted }
            }
        }
    }
    
    func getTodos() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        Task {
            if let todosList = await firebaseService.fetchAllTodos() {
                let pending = todosList.filter { !$0.isCompleted }
                let completed = todosList.filter { $0.isCompleted }
                
                DispatchQueue.main.async {
                    
                    self.pendingTodos = pending
                    self.completedTodos = completed
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
        Task {
            await firebaseService.deleteTodo(id: id)
            
            if let index = todos.firstIndex(where: { $0.id == id }) {
                todos.remove(at: index)
            }
        
            DispatchQueue.main.async {
                self.pendingTodos = self.todos
                self.completedTodos = self.todos
            }
        }
    }
}
