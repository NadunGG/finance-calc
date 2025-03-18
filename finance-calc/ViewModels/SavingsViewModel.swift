import Foundation

class SavingsViewModel: ObservableObject {
    enum CalculationType: String, CaseIterable {
        case numberOfPayments = "Number of Payments (N)"
        case initialInvestment = "Initial Investment (P)"
        case futureValue = "Future Value (A)"
        case monthlyContribution = "Monthly Contribution (PMT)"
        case interestRate = "Interest Rate (r)"
    }
    
    @Published var initialInvestment: String = ""
    @Published var futureValue: String = ""
    @Published var monthlyContribution: String = ""
    @Published var interestRate: String = ""
    @Published var numberOfPayments: String = ""
    @Published var paymentDue: String = "1" // Default to end of period
    @Published var selectedCalculation: CalculationType = .futureValue
    
    @Published var result: String?
    @Published var errorMessage: String?
    
    private let savingsCalc = SavingsCalculator()
    
    func calculate() {
        switch selectedCalculation {
        case .futureValue:
            guard let P = Double(initialInvestment),
                  let PMT = Double(monthlyContribution),
                  let r = Double(interestRate),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Monthly Contribution, Interest Rate, Number of Payments, and Payment Due."
                return
            }
            let A = savingsCalc.calculateFutureValue(P: P, PMT: PMT, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", A)
                self.errorMessage = nil
            }
            
        case .initialInvestment:
            guard let PMT = Double(monthlyContribution),
                  let A = Double(futureValue),
                  let r = Double(interestRate),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Monthly Contribution, Future Value, Interest Rate, Number of Payments, and Payment Due."
                return
            }
            let P = savingsCalc.calculateInitialInvestment(A: A, PMT: PMT, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", P)
                self.errorMessage = nil
            }
            
        case .numberOfPayments:
            guard let P = Double(initialInvestment),
                  let PMT = Double(monthlyContribution),
                  let A = Double(futureValue),
                  let r = Double(interestRate),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Monthly Contribution, Future Value, Interest Rate, and Payment Due."
                return
            }
            if let N = savingsCalc.calculateNumberOfPayments(P: P, PMT: PMT, A: A, r: r, pmtAt: pmtAt == 0 ? .beginning : .end) {
                DispatchQueue.main.async {
                    self.result = String(format: "%.2f", N)
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not compute number of payments."
                }
            }
            
        case .monthlyContribution:
            guard let P = Double(initialInvestment),
                  let A = Double(futureValue),
                  let r = Double(interestRate),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Future Value, Interest Rate, Number of Payments, and Payment Due."
                return
            }
            let PMT = savingsCalc.calculateMonthlyContribution(A: A, P: P, r: r, n: N, pmtAt: pmtAt == 0 ? .beginning : .end)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", PMT)
                self.errorMessage = nil
            }
            
        case .interestRate:
            guard let P = Double(initialInvestment),
                  let PMT = Double(monthlyContribution),
                  let A = Double(futureValue),
                  let N = Double(numberOfPayments),
                  let pmtAt = Int(paymentDue) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Monthly Contribution, Future Value, Number of Payments, and Payment Due."
                return
            }
            if let r = savingsCalc.calculateInterestRate(P: P, PMT: PMT, A: A, n: N, pmtAt: pmtAt == 0 ? .beginning : .end) {
                DispatchQueue.main.async {
                    self.result = String(format: "%.2f%%", r)
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
