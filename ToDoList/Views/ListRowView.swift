import SwiftUI

struct ListRowView: View {
    
    @ObservedObject private var viewModel = ListViewModel()
    
    let todo: ToDo
    
    var body: some View {
        HStack {
            Image(systemName: todo.isCompleted ? "checkmark.circle": "circle")
                .foregroundColor(.background)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(todo.title ?? "")
                    .font(.custom("Avenir", size: 20))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                //                HStack {
                //                    Image(systemName: "calendar")
                //                    Text("\(String.formattedDate(todo.deadline ?? Date()))")
                //                        .font(.custom("Avenir", size: 15))
                //                        .foregroundColor(.gray)
                //                }
            }
        }
    }
}

#Preview {
    ListRowView(todo:ToDo(id: "", title:"Test", notes:"", dueDate: Date(), isCompleted: true))
}
