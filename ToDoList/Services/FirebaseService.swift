import Foundation
import FirebaseFirestore


struct FirebaseService {
    
    private let db = Firestore.firestore()
    
    func addTodo(todo: ToDo) async {
        do {
            try await db.collection("todos").document(todo.id).setData([
                "title": todo.title,
                "details": todo.details,
                "deadline": todo.deadline,
                "id": todo.id
                
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func getTodos() async -> [ToDo]? {
        do {
            let querySnapshot = try await db.collection("todos").getDocuments()
            
            let todos: [ToDoFirebase] = try querySnapshot.documents.compactMap { document in
                try document.data(as: ToDoFirebase.self)
            }
            
//            var todos: [ToDo] = []
//            
//            for document in querySnapshot.documents {
//                let data = document.data()
//                let title = data["title"] as? String ?? ""
//                let details = data["detauls"] as? String ?? ""
//                let id = data["id"] as? String ?? ""
//                let deadline = (data["deadline"] as? Timestamp)?.dateValue() ?? Date()
//                let todo = ToDo(id: id, title: title, details: details, deadline: deadline)
//                todos.append(todo)
//            }
            return todos.map { toDoFirebase in
                ToDo(id: toDoFirebase.id ?? "", title: toDoFirebase.title ?? "", details: toDoFirebase.details ?? "", deadline: toDoFirebase.deadline ?? Date()) 
            }
        } catch {
            print("Error getting documents: \(error)")
            return nil
        }
    }
    func deleteTodo(id: String) async {
        print("Attempting to delete todo with ID: \(id)") 
         do {
             try await db.collection("todos").document(id).delete()
            print("Document successfully removed!")
            } catch {
            print("Error removing document: \(error)")
            }
        }
    }

    
    
    
