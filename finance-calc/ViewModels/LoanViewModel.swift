import Foundation

class LoanViewModel: ObservableObject {
    enum CalculationType: String, CaseIterable {
        case loanAmount = "Loan Amount (P)"
        case interestRate = "Interest Rate (r)"
        case numberOfPayments = "Number of Payments (N)"
        case monthlyPayment = "Monthly Payment (PMT)"
    }
    
    @Published var selectedCalculation: CalculationType = .loanAmount
    @Published var loanAmount: String = ""
    @Published var interestRate: String = ""
    @Published var numberOfPayments: String = ""
    @Published var monthlyPayment: String = ""
    @Published var paymentDue: String = "1" // Default to end of period
    @Published var result: String?
    @Published var errorMessage: String?
    
    private let loanCalc = LoanCalculator()
    
    func calculateValue() {
        switch selectedCalculation {
        case .monthlyPayment:
            guard let P = Double(loanAmount),
                  let r = Double(interestRate),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Loan Amount, Interest Rate, Number of Payments, and Payment Due."
                return
            }
            let PMT = loanCalc.calculateMonthlyPayment(P: P, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.monthlyPayment = String(format: "%.2f", PMT)
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
            let P = loanCalc.calculateLoanAmount(PMT: PMT, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.loanAmount = String(format: "%.2f", P)
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
            if let N = loanCalc.calculateNumberOfPayments(P: P, PMT: PMT, r: r, pmtAt: pmtAt == 0 ? .beginning : .end) {
                DispatchQueue.main.async {
                    self.numberOfPayments = String(format: "%.2f", N)
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not compute number of payments."
                }
            }
            
        case .interestRate:
            guard let P = Double(loanAmount),
                  let PMT = Double(monthlyPayment),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Loan Amount, Monthly Payment, Number of Payments, and Payment Due."
                return
            }
            if let r = loanCalc.calculateInterestRate(P: P, PMT: PMT, n: N, pmtAt: pmtAt == 0 ? .beginning : .end) {
                DispatchQueue.main.async {
                    self.interestRate = String(format: "%.2f", r)
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not estimate interest rate. Try different values."
                }
            }
        }
    }
}
