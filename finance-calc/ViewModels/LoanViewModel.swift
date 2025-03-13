import Foundation

class LoanViewModel: ObservableObject {
    @Published var loanAmount: String = "" // P
    @Published var interestRate: String = "" // r
    @Published var numberOfYears: String = "" // N
    @Published var monthlyPayment: String? // PMT (Result)
    
    @Published var errorMessage: String?
    
    func calculateMonthlyPayment() {
        guard let P = Double(loanAmount), let r = Double(interestRate), let N = Double(numberOfYears) else {
            errorMessage = "Please enter valid numerical values."
            return
        }
        
        let monthlyRate = (r / 100) / 12 // Convert r to decimal and monthly rate
        let totalMonths = N * 12
        
        let PMT = FinancialFormulas.calculatePayment(P: P, r: r / 100, N: N, CpY: 12)
        
        DispatchQueue.main.async {
            self.monthlyPayment = String(format: "%.2f", PMT)
            self.errorMessage = nil
        }
    }
}
