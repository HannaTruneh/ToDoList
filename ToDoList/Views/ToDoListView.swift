
import SwiftUI

struct ToDoListView: View {
    
@ObservedObject var viewModel = ListViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.sections, id: \.name) { section in
                SectionView(viewModel: viewModel, section: section)
            }
        }
    }
}

#Preview {
    ToDoListView()
}
