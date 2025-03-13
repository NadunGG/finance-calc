import SwiftUI

struct SavingsView: View {
    @StateObject private var viewModel = SavingsViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Savings Calculation")) {
                TextField("Initial Investment (P)", text: $viewModel.initialInvestment)
                    .keyboardType(.decimalPad)
                
                TextField("Monthly Contribution (PMT)", text: $viewModel.monthlyContribution)
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
        .navigationTitle("Savings Calculator")
    }
}

struct SavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsView()
    }
}
