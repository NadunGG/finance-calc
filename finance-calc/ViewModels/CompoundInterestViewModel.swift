import Foundation

class CompoundInterestViewModel: ObservableObject {
    @Published var presentValue: String = "" // P
    @Published var interestRate: String = "" // r
    @Published var numberOfYears: String = "" // N
    @Published var futureValue: String? // A (Result)
    
    @Published var errorMessage: String?
    
    func calculateFutureValue() {
        guard let P = Double(presentValue), let r = Double(interestRate), let N = Double(numberOfYears) else {
            errorMessage = "Please enter valid numerical values."
            return
        }
        
        let A = FinancialFormulas.calculateFutureValue(P: P, r: r / 100, N: N, CpY: 12) // Convert r to decimal
        
        DispatchQueue.main.async {
            self.futureValue = String(format: "%.2f", A)
            self.errorMessage = nil
        }
    }
}
