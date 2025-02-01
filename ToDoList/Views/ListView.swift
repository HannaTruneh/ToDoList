import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel = ListViewModel()
    
    @State private var showAddTodoSheet = false
    
    let colums = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    if viewModel.todos.isEmpty {
                        NoTodosView(viewModel: viewModel)
                    } else {
                        List {
                            SectionView(viewModel: viewModel, name: "Pending", todos: viewModel.pendingTodos)
                            
                            SectionView(viewModel: viewModel, name: "Completed", todos: viewModel.completedTodos)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("background"))
            .navigationTitle("To-Do List")
            .onAppear {
                Task {
                    viewModel.getTodos()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showAddTodoSheet.toggle()
                    }) {
                        Label("Add Todo", systemImage: "plus")
                            .imageScale(.large)
                            .scaleEffect(3)
                    }
                }
            }
            .sheet(isPresented: $showAddTodoSheet) {
                        AddView(viewModel: viewModel)
                    }
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "Avenir", size: 30) ?? UIFont.boldSystemFont(ofSize: 40)
                ]
            }
        }
    }
}
#Preview {
    ListView()
}

extension String {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
