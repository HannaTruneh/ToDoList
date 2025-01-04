import Foundation
import SwiftData

@Model
class ToDo {
    var title: String
    var details: String
    var deadline: Date
    
    
    init(title: String, details: String, deadline: Date) {
        self.title = title
        self.details = details
        self.deadline = deadline
    }
}

