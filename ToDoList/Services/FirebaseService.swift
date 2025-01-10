import Foundation
import FirebaseFirestore


struct FirebaseService {
    
    private let db = Firestore.firestore()
    
    func addTodo(todo: ToDo) async {
        do {
            try await db.collection("todos").document(UUID().uuidString).setData([
                "title": todo.title,
                "details": todo.details,
                "deadline": todo.deadline,
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func getTodos() async -> [ToDo]? {
        do {
            let querySnapshot = try await db.collection("todos").getDocuments()
            
            var todos: [ToDo] = []
            
            for document in querySnapshot.documents {
                let data = document.data()
                let title = data["title"] as? String ?? ""
                let details = data["detauls"] as? String ?? ""
                let todo = ToDo(id: UUID().uuidString, title: title, details: details, deadline: Date())
                todos.append(todo)
            }
            return todos
        } catch {
            print("Error getting documents: \(error)")
            return nil
        }
    }
    func deleteTodo(id: String) async {
         do {
             try await db.collection("todos").document(id).delete()
            print("Document successfully removed!")
            } catch {
            print("Error removing document: \(error)")
            }
        }
    }

    
    
    
