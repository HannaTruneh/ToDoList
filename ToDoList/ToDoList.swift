

import SwiftUI
import SwiftData

struct ToDoList: View {
    
    @StateObject private var viewModel = ToDoListViewModel()
    
    @State private var newTodo = ""
    @State private var newTodoDeadline = Date()
    @State private var isShowingSheet = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.todos) { todo in
                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .font(.headline)
                            Text("Deadline: \(formattedDate(todo.deadline))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteToDo)
                }
                .navigationTitle("To-Do List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowingSheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $isShowingSheet) {
                    VStack {
                        TextField("New Task", text: $newTodo)
                            .bold()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        DatePicker("Select Deadline", selection: $newTodoDeadline, displayedComponents: .date)
                            .padding()
                        
                        Button("Save") {
                            if !newTodo.isEmpty {
                                viewModel.addNewToDo(title: newTodo, deadline: newTodoDeadline)
                                newTodo = ""
                                isShowingSheet = false
                            }
                        }
                        .padding()
                    }
                    .padding()
                }
            }
        }
    }
    
    
    private func deleteToDo(at offsets: IndexSet) {
        viewModel.deleteToDo(at: offsets)
    }
    
    
    private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter.string(from: date)
    }
}



#Preview {
    ToDoList()
        .modelContainer(for: ToDo.self, inMemory: true)
}
