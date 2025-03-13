import SwiftUI

struct MortgageView: View {
    @StateObject private var viewModel = MortgageViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Mortgage Calculation")) {
                TextField("Home Price (P)", text: $viewModel.homePrice)
                    .keyboardType(.decimalPad)
                
                TextField("Down Payment", text: $viewModel.downPayment)
                    .keyboardType(.decimalPad)
                
                TextField("Loan Term (Years, N)", text: $viewModel.loanTerm)
                    .keyboardType(.decimalPad)
                
                TextField("Interest Rate (%)", text: $viewModel.interestRate)
                    .keyboardType(.decimalPad)
                
                Button("Calculate") {
                    viewModel.calculateMortgagePayment()
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
        .navigationTitle("Mortgage Calculator")
    }
}

struct MortgageView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageView()
    }
}
