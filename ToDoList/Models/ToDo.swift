import Foundation


class ToDo:  Codable, Identifiable {
    var id: String
    var title: String?
    var notes: String?
    var dueDate: Date?
    var isCompleted: Bool
    
    init(id: String, title: String? = "", notes: String? = "", dueDate: Date? = Date(), isCompleted: Bool) {
        self.id = id
        self.title = title
        self.notes = notes
        self.dueDate = dueDate
        self.isCompleted = isCompleted
    }
}



