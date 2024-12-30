import Foundation

struct ToDo: Identifiable {
    var id = UUID() 
    var title: String
    var deadline: Date
    
    init(title: String, deadline: Date) {
        self.title = title
        self.deadline = deadline
    }
}
