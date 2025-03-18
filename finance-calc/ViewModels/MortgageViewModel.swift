import Foundation

class MortgageViewModel: ObservableObject {
    enum CalculationType: String, CaseIterable {
        case loanAmount = "Loan Amount (P)"
        case numberOfPayments = "Number of Payments (N)"
        case monthlyPayment = "Monthly Payment (PMT)"
    }
    
    @Published var loanAmount: String = ""
    @Published var interestRate: String = ""
    @Published var numberOfPayments: String = ""
    @Published var monthlyPayment: String = ""
    @Published var paymentDue: String = "1" // Default to end of period
    @Published var selectedCalculation: CalculationType = .monthlyPayment
    
    @Published var result: String?
    @Published var errorMessage: String?
    
    private let mortgageCalc = MortgageCalculator()
    
    func calculate() {
        switch selectedCalculation {
        case .monthlyPayment:
            guard let P = Double(loanAmount),
                  let r = Double(interestRate),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Loan Amount, Interest Rate, Number of Payments, and Payment Due."
                return
            }
            let PMT = mortgageCalc.calculateMonthlyPayment(P: P, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", PMT)
                self.errorMessage = nil
            }
            
        case .loanAmount:
            guard let PMT = Double(monthlyPayment),
                  let r = Double(interestRate),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Monthly Payment, Interest Rate, Number of Payments, and Payment Due."
                return
            }
            let P = mortgageCalc.calculateLoanAmount(PMT: PMT, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", P)
                self.errorMessage = nil
            }
            
        case .numberOfPayments:
            guard let P = Double(loanAmount),
                  let PMT = Double(monthlyPayment),
                  let r = Double(interestRate),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Loan Amount, Monthly Payment, Interest Rate, and Payment Due."
                return
            }
            if let N = mortgageCalc.calculateNumberOfPayments(P: P, PMT: PMT, r: r, pmtAt: pmtAt == 0 ? .beginning : .end) {
                DispatchQueue.main.async {
                    self.result = String(format: "%.2f", N)
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not compute number of payments."
                }
            }
        }
    }
}
