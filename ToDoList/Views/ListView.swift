import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel = ListViewModel()
    
    @State private var showAddTodoSheet = false
    
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
                            ForEach(viewModel.sections, id: \.name) { section in
                                SectionView(viewModel: viewModel, section: section)
                            }
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
