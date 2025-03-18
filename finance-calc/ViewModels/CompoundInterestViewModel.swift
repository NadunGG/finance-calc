class CompoundInterestViewModel: ObservableObject {
    enum CalculationType: String, CaseIterable {
        case interestRate = "Interest Rate (r)"
        case numberOfYears = "Number of Years (N)"
        case presentValue = "Initial Investment (P)"
        case futureValue = "Future Value (A)"
    }
    
    @Published var selectedCalculation: CalculationType = .futureValue
    @Published var initialInvestment: String = ""
    @Published var futureValue: String = ""
    @Published var interestRate: String = ""
    @Published var numberOfYears: String = ""
    @Published var result: String?
    @Published var errorMessage: String?
    
    private let compoundCalc = CompoundInterestCalculator()
    
    func calculate() {
        switch selectedCalculation {
        case .futureValue:
            guard let P = Double(initialInvestment),
                  let r = Double(interestRate),
                  let N = Double(numberOfYears) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Interest Rate, and Number of Years."
                return
            }
            let A = compoundCalc.calculateFutureValue(P: P, r: r, n: N)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", A)
                self.errorMessage = nil
            }
            
        case .presentValue:
            guard let A = Double(futureValue),
                  let r = Double(interestRate),
                  let N = Double(numberOfYears) else {
                errorMessage = "Please enter valid numerical values for Future Value, Interest Rate, and Number of Years."
                return
            }
            let P = compoundCalc.calculatePresentValue(A: A, r: r, n: N)
            DispatchQueue.main.async {
                self.result = String(format: "%.2f", P)
                self.errorMessage = nil
            }
            
        case .interestRate:
            guard let P = Double(initialInvestment),
                  let A = Double(futureValue),
                  let N = Double(numberOfYears) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Future Value, and Number of Years."
                return
            }
            if let r = compoundCalc.calculateInterestRate(P: P, A: A, n: N) {
                DispatchQueue.main.async {
                    self.result = String(format: "%.2f%%", r)
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not estimate interest rate. Try different values."
                }
            }
            
        case .numberOfYears:
            guard let P = Double(initialInvestment),
                  let A = Double(futureValue),
                  let r = Double(interestRate) else {
                errorMessage = "Please enter valid numerical values for Initial Investment, Future Value, and Interest Rate."
                return
            }
            if let N = compoundCalc.calculateNumberOfYears(P: P, A: A, r: r) {
                DispatchQueue.main.async {
                    self.result = String(format: "%.2f years", N)
                    self.errorMessage = nil
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Could not compute number of years."
                }
            }
        }
    }
}
