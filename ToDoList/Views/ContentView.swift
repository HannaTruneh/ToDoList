import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ListViewModel()
    
    @State private var showAddTodoSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .loading:
                    ProgressView()
                    
                case .empty:
                    EmptyStateView(viewModel: viewModel)
                    
                case .loaded:
                    ToDoListView(viewModel: viewModel)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("background"))
            .navigationTitle("To-Do List")
            .onAppear {
                UINavigationBar.appearance().largeTitleTextAttributes = [
                    .font: UIFont(name: "Avenir", size: 30) ?? UIFont.boldSystemFont(ofSize: 40)
                ]
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
        }
    }
}

#Preview {
    ContentView()
}

extension String {
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
