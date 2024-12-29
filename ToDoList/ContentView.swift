//
//  ContentView.swift
//  ToDoList
//
//  Created by Hanna Truneh on 29/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tasks = [String]()
    @State private var newTask = ""
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                    }
                }
                .navigationTitle("To-Do List")
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("Edit")
                            .foregroundStyle(Color.blue)
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowingSheet.toggle()
                        }) {
                            Text("Add")
                                .bold()
                        }
                    }
                }
                .sheet(isPresented: $isShowingSheet) {
                    VStack {
                        Text("It's a sheet")
                        Button(action: {
                            print("")
                        }) {
                            Text("Add Task")
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
       
        //            func addTask() {
        //                if newTask.isEmpty {
        //                    tasks.append(newTask)
        //                    newTask = ""
        //                }
        //            }
        
        
   
