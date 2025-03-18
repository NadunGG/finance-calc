import SwiftUI

struct MortgageView: View {
    @StateObject private var viewModel = MortgageViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Mortgage Calculation")) {
                Picker("Solve for", selection: $viewModel.selectedCalculation) {
                    ForEach(MortgageViewModel.CalculationType.allCases, id: \ .self) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            if viewModel.selectedCalculation != .loanAmount {
                TextField("Loan Amount", text: $viewModel.loanAmount)
                    .keyboardType(.decimalPad)
            }
            
            TextField("Interest Rate (%r)", text: $viewModel.interestRate)
                .keyboardType(.decimalPad)
            
            if viewModel.selectedCalculation != .numberOfPayments {
                TextField("Number of Payments", text: $viewModel.numberOfPayments)
                    .keyboardType(.decimalPad)
            }
            
            if viewModel.selectedCalculation != .monthlyPayment {
                TextField("Monthly Payment", text: $viewModel.monthlyPayment)
                    .keyboardType(.decimalPad)
            }
            
            Picker("Payment Due", selection: $viewModel.paymentDue) {
                Text("Beginning of Period").tag("0")
                Text("End of Period").tag("1")
            }
            
            
            Button("Calculate") {
                viewModel.calculate()
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
            }}
        .navigationTitle("Mortgage Calculator")
    }
}

struct MortgageView_Previews: PreviewProvider {
    static var previews: some View {
        MortgageView()
    }
}
