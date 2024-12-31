

import SwiftUI
import SwiftData

struct ToDoList: View {
    
    @Query private var todos: [ToDo]
    
    @State private var newTodo = ""
    @State private var newTodoDeadline = Date()
    @State private var isShowingSheet = false
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(todos, id: \.id.self) { todo in
                        VStack(alignment: .leading) {
                            Text(todo.title)
                                .font(.headline)
                            Text("Deadline: \(todo.deadline, formatter: dateFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
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
                                let newToDo = ToDo(title: newTodo, deadline: newTodoDeadline)
                                modelContext.insert(newToDo)
                                                                
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
    
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}




#Preview {
    ToDoList()
        .modelContainer(for: ToDo.self, inMemory: true)
}
