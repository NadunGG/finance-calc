import SwiftUI

struct LoanView: View {
    @StateObject private var viewModel = LoanViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Loan Calculation")) {
                TextField("Loan Amount (P)", text: $viewModel.loanAmount)
                    .keyboardType(.decimalPad)
                
                TextField("Interest Rate (%)", text: $viewModel.interestRate)
                    .keyboardType(.decimalPad)
                
                TextField("Number of Years (N)", text: $viewModel.numberOfYears)
                    .keyboardType(.decimalPad)
                
                Button("Calculate") {
                    viewModel.calculateMonthlyPayment()
                }
            }
            
            if let monthlyPayment = viewModel.monthlyPayment {
                Section(header: Text("Monthly Payment")) {
                    Text("Rs. \(monthlyPayment)")
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
