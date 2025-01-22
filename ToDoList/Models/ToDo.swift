import Foundation


class ToDo:  Codable {
    var id: String?
    var title: String?
    var details: String?
    var deadline: Date?
    
    init(id: String? = "", title: String? = "", details: String? = "", deadline: Date? = Date()) {
        self.id = id
        self.title = title
        self.details = details
        self.deadline = deadline
    }
}



