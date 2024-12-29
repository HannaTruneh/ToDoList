//
//  ContentView.swift
//  ToDoList
//
//  Created by Hanna Truneh on 29/12/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State  private var tasks = [String]()
    @State private var newTask = ""
    @State private var isShoeingSheet = false
    
    
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
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Add")
                            .bold()
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

func addTask() {
    if newTask.isEmpty {
        tasks.append(newTask)
        newTask = ""
    }
}

#Preview {
    ContentView()
}
