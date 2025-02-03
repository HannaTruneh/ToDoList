import Foundation


class ListViewModel: ObservableObject {
    
    @Published var showAddTodoSheet: Bool = false
    @Published var todos: [ToDo] = []
    @Published var pendingTodos: [ToDo] = []
    @Published var completedTodos: [ToDo] = []
    @Published var sections: [ListSection] = []
    @Published var viewState: ViewState = .loading
    
    enum ViewState: Equatable {
        case loading
        case loaded
        case empty
    }
    
    let firebaseService = FirebaseService()
    
    
    
    func createTodo(newTodo: ToDo) {
        DispatchQueue.main.async {
            
            self.pendingTodos.append(newTodo)
            self.updateSections()
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
                self.updateSections()
            }
        }
    }
    
    func getTodos() {
        DispatchQueue.main.async {
            self.viewState = .loading
        }
        
        Task {
            if let todosList = await firebaseService.fetchAllTodos() {
                let pending = todosList.filter { !$0.isCompleted }
                let completed = todosList.filter { $0.isCompleted }
                
                DispatchQueue.main.async {
                    self.pendingTodos = pending
                    self.completedTodos = completed
                    self.todos = todosList
                    self.updateSections()
                    self.viewState = todosList.isEmpty ? .empty : .loaded
                }
            } else {
                DispatchQueue.main.async {
                    self.viewState = .empty
                }
            }
        }
    }
    
    func deleteTodo(id: String) {
        Task {
            await firebaseService.deleteTodo(id: id)
            
            DispatchQueue.main.async {
                self.todos = self.todos.filter { $0.id != id }
                self.pendingTodos = self.todos.filter { !$0.isCompleted }
                self.completedTodos = self.todos.filter { $0.isCompleted }
                self.updateSections()
                
                if self.todos.isEmpty {
                    self.viewState = .empty
                } else {
                    self.viewState = .loaded
                }
            }
        }
    }
    
    func updateSections() {
        let pendingSection = ListSection(name: "Pending", todos: self.pendingTodos)
        let completedSection = ListSection(name: "Completed", todos: self.completedTodos)
        
        self.sections = [pendingSection, completedSection]
    }
}



