import SwiftUI

struct LoanView: View {
    @StateObject private var viewModel = LoanViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Loan Calculation")) {
                Picker("Solve for:", selection: $viewModel.selectedCalculation) {
                    ForEach(LoanViewModel.CalculationType.allCases, id: \ .self) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if viewModel.selectedCalculation != .loanAmount {
                    TextField("Loan Amount (P)", text: $viewModel.loanAmount)
                        .keyboardType(.decimalPad)
                }
                
                if viewModel.selectedCalculation != .interestRate {
                    TextField("Interest Rate (%)", text: $viewModel.interestRate)
                        .keyboardType(.decimalPad)
                }
                
                if viewModel.selectedCalculation != .numberOfPayments {
                    TextField("Number of Payments (N)", text: $viewModel.numberOfPayments)
                        .keyboardType(.decimalPad)
                }
                
                if viewModel.selectedCalculation != .monthlyPayment {
                    TextField("Monthly Payment (PMT)", text: $viewModel.monthlyPayment)
                        .keyboardType(.decimalPad)
                }

                Picker("Payment Due", selection: $viewModel.paymentDue) {
                    Text("Beginning of Period").tag("0")
                    Text("End of Period").tag("1")
                }
                
                Button("Calculate") {
                    viewModel.calculateValue()
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
        .navigationTitle("Loan Calculator")
    }
}

struct LoanView_Previews: PreviewProvider {
    static var previews: some View {
        LoanView()
    }
}
