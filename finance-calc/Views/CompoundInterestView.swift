import SwiftUI

struct CompoundInterestView: View {
    @StateObject private var viewModel = CompoundInterestViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Compound Interest Calculation")) {
                TextField("Initial Investment (P)", text: $viewModel.presentValue)
                    .keyboardType(.decimalPad)
                
                TextField("Interest Rate (%)", text: $viewModel.interestRate)
                    .keyboardType(.decimalPad)
                
                TextField("Number of Years (N)", text: $viewModel.numberOfYears)
                    .keyboardType(.decimalPad)
                
                Button("Calculate") {
                    viewModel.calculateFutureValue()
                }
            }
            
            if let futureValue = viewModel.futureValue {
                Section(header: Text("Future Value")) {
                    Text("Rs. \(futureValue)")
                        .font(.headline)
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Compound Interest")
    }
}

struct CompoundInterestView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundInterestView()
    }
}
