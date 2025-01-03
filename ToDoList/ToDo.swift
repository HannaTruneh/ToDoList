import Foundation
import SwiftData

@Model
class ToDo {
    var title: String
    var deadline: Date
    
    init(title: String, deadline: Date) {
        self.title = title
        self.deadline = deadline
    }
}

