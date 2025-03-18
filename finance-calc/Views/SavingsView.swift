import SwiftUI

struct SavingsView: View {
    @StateObject private var viewModel = SavingsViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Savings Calculation")) {
                Picker("Solve for", selection: $viewModel.selectedCalculation) {
                    ForEach(SavingsViewModel.CalculationType.allCases, id: \ .self) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                if viewModel.selectedCalculation != .initialInvestment {
                    TextField("Initial Investment (P)", text: $viewModel.initialInvestment)
                        .keyboardType(.decimalPad)
                }

                if viewModel.selectedCalculation != .monthlyContribution {
                TextField("Monthly Contribution (PMT)", text: $viewModel.monthlyContribution)
                    .keyboardType(.decimalPad)
                }

                if viewModel.selectedCalculation != .interestRate {
                TextField("Interest Rate (%r)", text: $viewModel.interestRate)
                    .keyboardType(.decimalPad)
                }

                if viewModel.selectedCalculation != .numberOfPayments {
                    TextField("Number of Payments (N)", text: $viewModel.numberOfPayments)
                        .keyboardType(.decimalPad)
                }
                
                if viewModel.selectedCalculation != .futureValue {
                    TextField("Future Value (A)", text: $viewModel.futureValue)
                        .keyboardType(.decimalPad)
                }

                Picker("Payment Due", selection: $viewModel.paymentDue) {
                    Text("Beginning of Period").tag("0")
                    Text("End of Period").tag("1")
                }

                Button("Calculate") {
                    viewModel.calculate()
                }
            }
            
            if let result = viewModel.result {
                Section(header: Text("Result")) {
                    Text("Rs. \(result)")
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
