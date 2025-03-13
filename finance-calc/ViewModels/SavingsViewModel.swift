import Foundation

class SavingsViewModel: ObservableObject {
    @Published var initialInvestment: String = "" // P
    @Published var monthlyContribution: String = "" // PMT
    @Published var interestRate: String = "" // r
    @Published var numberOfYears: String = "" // N
    @Published var futureValue: String? // A (Result)
    
    @Published var errorMessage: String?
    
    func calculateFutureValue() {
        guard let P = Double(initialInvestment), let PMT = Double(monthlyContribution), let r = Double(interestRate), let N = Double(numberOfYears) else {
            errorMessage = "Please enter valid numerical values."
            return
        }
        
        let monthlyRate = (r / 100) / 12 // Convert r to decimal and monthly rate
        let totalMonths = N * 12
        let futureValueLumpSum = FinancialFormulas.calculateFutureValue(P: P, r: r / 100, N: N, CpY: 12)
        let futureValueContributions = PMT * ((pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate)
        
        let A = futureValueLumpSum + futureValueContributions
        
        DispatchQueue.main.async {
            self.futureValue = String(format: "%.2f", A)
            self.errorMessage = nil
        }
    }
}
