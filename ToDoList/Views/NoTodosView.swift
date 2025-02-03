import SwiftUI

struct NoTodosView: View {
    
    @ObservedObject var viewModel: ListViewModel
    
    @State private var showAddTodoSheet = false
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Spacer(minLength: 170)
                
                Text("There are no todos")
                    .font(.custom("Avenir", size: 30))
                    .fontWeight(.semibold)
                
                Text("Click the add button and add a new item to your todo list")
                    .font(.custom("Avenir", size: 18))
                
                Button(action: {
                    showAddTodoSheet.toggle()
                }) {
                    Text("Add new todo")
                        .foregroundColor(.black)
                        .font(.custom("Avenir", size: 15))
                        .frame(height: 46)
                        .frame(maxWidth: .infinity)
                        .background(Color.addButton)
                        .cornerRadius(10)
                }
                .padding(.horizontal, animate ? 30 : 50 )
            }
            .multilineTextAlignment(.center)
            .padding(50)
            .onAppear(perform: addAnimation)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .scrollContentBackground(.hidden)
        .background(Color("background"))
        .sheet(isPresented: $showAddTodoSheet) {
                    AddView(viewModel: viewModel)
                }
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



