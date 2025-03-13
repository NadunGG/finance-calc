import SwiftUI

struct HelpView: View {
    @StateObject private var viewModel = HelpViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Help & Instructions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(viewModel.helpText)
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Help")
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
