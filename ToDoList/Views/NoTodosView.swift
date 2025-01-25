//
//  NoTodosView.swift
//  ToDoList
//
//  Created by Shay Shimony on 25/01/2025.
//

import SwiftUI

struct NoTodosView: View {
    
    @ObservedObject var viewModel: ListViewModel
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer(minLength: 170)
                Text("There are no todos")
                    .font(.custom("Avenir", size: 30))
                    .fontWeight(.semibold)
                Text("Click the add button and add a new item to your todo list")
//                    .font(.system(size: 18, weight: .regular, design: .default))
                    .font(.custom("Avenir", size: 18))
                NavigationLink(
                    destination: AddView(viewModel: viewModel),
                    label: {
                        Text("Add new todo")
                            .foregroundColor(.black)
                            .font(.custom("Avenir", size: 15))
                            .frame(height: 46)
                            .frame(maxWidth: .infinity)
//                            .background(
//                                Rectangle()
//                                    .stroke(Color.black, lineWidth: 1)
//                                    .frame(width: 150, height: 40)
//                            )
                            .background(Color.addButton)
                            .cornerRadius(10)
                    })
                .padding(.horizontal, animate ? 30 : 50 )
            }
            .multilineTextAlignment(.center)
            .padding(50)
            .onAppear(perform: addAnimation)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
        .background(Color("background"))
        
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}
    #Preview {
        NavigationView{
            NoTodosView(viewModel: ListViewModel())
        }
    }
    
    
    
