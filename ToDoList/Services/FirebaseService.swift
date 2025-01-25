import Foundation
import FirebaseFirestore


struct FirebaseService {
    
private let db = Firestore.firestore()
    
    func createTodo(todo: ToDo) async {
        do {
            try await db.collection("todos").document(todo.id).setData([
                "title": todo.title ?? "",
                "details": todo.details ?? "",
                "deadline": todo.deadline ?? Date(),
                "id": todo.id,
                "isCompleted": false
                
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func updateTodo(todo: ToDo) async {
        do {
            try await db.collection("todos").document(todo.id).updateData([
                "lastUpdated": FieldValue.serverTimestamp(),
                "title": todo.title ?? "",
                "details": todo.details ?? "",
                "deadline": todo.deadline ?? Date()
            ])
            print("Document successfully updated")
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    func updateCompletion(todo: ToDo)  async {
        do {
            try await db.collection("todos").document(todo.id).updateData([
                "isCompleted": !todo.isCompleted
            ])
            print("Document successfully updated")
            
        } catch {
            print("Error updating document: \(error)")
        }
    }
    
    func fetchAllTodos() async -> [ToDo]? {
        do {
            let querySnapshot = try await db.collection("todos").whereField("isCompleted", isEqualTo: false).getDocuments()
            let todos: [ToDo] = try querySnapshot.documents.compactMap { document in
                try document.data(as: ToDo.self)
            }
            return todos.map { todo in
                ToDo(id: todo.id,
                     title: todo.title ?? "",
                     details: todo.details ?? "",
                     deadline: todo.deadline ?? Date())
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



