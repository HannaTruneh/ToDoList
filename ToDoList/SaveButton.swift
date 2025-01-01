



import SwiftUI

struct SaveButton: View {
    
    var text: String

    var body: some View {
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

#Preview {
    SaveButton(text: "Test")
}
