

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
                    VStack(spacing: 20) {
                        
                        Spacer().frame(height: 10)
                        
                        TextField("New Task", text: $newTodo)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .textFieldStyle(PlainTextFieldStyle())
                        
                        DatePicker("Deadline", selection: $newTodoDeadline, displayedComponents: [.date, .hourAndMinute])
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        
                        Spacer()
                        
                        Button(action: {
                            if !newTodo.isEmpty {
                                viewModel.addNewToDo(title: newTodo, deadline: newTodoDeadline)
                                newTodo = ""
                                isShowingSheet = false
                            }
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .font(.headline)
                                .cornerRadius(10)
                                .bold()
                        }
                        .padding(.horizontal)
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
        formatter.timeStyle = .short
        return formatter.string(from: date)
        
    }
}



#Preview {
    ToDoList()
        .modelContainer(for: ToDo.self, inMemory: true)
}
