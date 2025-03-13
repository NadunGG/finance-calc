import Foundation

class MortgageViewModel: ObservableObject {
    @Published var homePrice: String = "" // P
    @Published var downPayment: String = "" // Initial amount paid upfront
    @Published var loanTerm: String = "" // N (Years)
    @Published var interestRate: String = "" // r
    @Published var monthlyPayment: String? // PMT (Result)
    
    @Published var errorMessage: String?
    
    func calculateMortgagePayment() {
        guard let homePrice = Double(homePrice), let downPayment = Double(downPayment), 
              let r = Double(interestRate), let N = Double(loanTerm) else {
            errorMessage = "Please enter valid numerical values."
            return
        }
        
        let P = homePrice - downPayment // Loan principal after down payment
        let monthlyRate = (r / 100) / 12 // Convert r to decimal and monthly rate
        let totalMonths = N * 12
        
        let PMT = FinancialFormulas.calculatePayment(P: P, r: r / 100, N: N, CpY: 12)
        
        DispatchQueue.main.async {
            self.monthlyPayment = String(format: "%.2f", PMT)
            self.errorMessage = nil
        }
    }
}
