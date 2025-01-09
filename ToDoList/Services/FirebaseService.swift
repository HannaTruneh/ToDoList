import Foundation
import FirebaseFirestore


struct FirebaseService {
    private let db = Firestore.firestore()
    
    func add(todo: ToDo) async {
        do {
            try await db.collection("todos").document(UUID().uuidString).setData([
                "title": todo.title,
                "details": todo.details,
                "deadline": todo.deadline
          ])
          print("Document successfully written!")
        } catch {
          print("Error writing document: \(error)")
        }
    }
}

