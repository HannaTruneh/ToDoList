import SwiftUI

struct SaveButton: View {
    
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(10)
                .bold()
                .padding(.horizontal)
        }
    }
}

#Preview {
    SaveButton(text: "Test", action: {})
}
