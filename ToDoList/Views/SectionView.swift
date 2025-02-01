import SwiftUI

struct SectionView: View {
    
    @ObservedObject var viewModel: ListViewModel
    
    
    var name: String
    var todos: [ToDo]
    
    var body: some View {
        
        Section(header: Text(name).font(.headline)) {
            ForEach(todos, id: \.id) { todo in
                NavigationLink(destination: EditView(todo: todo)) {
                    ListRowView(todo: todo)
                        .onTapGesture {
                            withAnimation {
                                viewModel.updateCompletion(todo: todo)
                            }
                        }
                        .transition(.move(edge: .top))
                }
                .scrollContentBackground(.hidden)
                .buttonStyle(PlainButtonStyle())
                .opacity(1)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let todo = todos[index]
                    viewModel.deleteTodo(id: todo.id)
                }
            }
        }
    }
}

#Preview {
    SectionView(viewModel: ListViewModel(), name: "Com", todos: [ToDo(id: "123", title: "TODO", notes: "", dueDate: Date(), isCompleted: true)])
}
