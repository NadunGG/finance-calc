import Foundation

struct SavingsCalculator {
    enum PaymentDue { case beginning, end }
    
    func calculateFutureValue(P: Double, PMT: Double, r: Double, n: Double, pmtAt: PaymentDue = .end) -> Double {
        let rate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + rate) : 1.0
        
        return P * pow(1 + rate, n) + PMT * factor * ((pow(1 + rate, n) - 1) / rate)
    }
    
    func calculateInitialInvestment(A: Double, PMT: Double, r: Double, n: Double, pmtAt: PaymentDue = .end) -> Double {
        let rate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + rate) : 1.0
        
        return (A - PMT * factor * ((pow(1 + rate, n) - 1) / rate)) / pow(1 + rate, n)
    }
    
    func calculateNumberOfPayments(P: Double, PMT: Double, A: Double, r: Double, pmtAt: PaymentDue = .end) -> Double? {
        let rate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + rate) : 1.0
        
        return log((A * rate + PMT * factor) / (P * rate + PMT * factor)) / log(1 + rate)
    }
    
    func calculateMonthlyContribution(A: Double, P: Double, r: Double, n: Double, pmtAt: PaymentDue = .end) -> Double {
        let rate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + rate) : 1.0
        
        return (A - P * pow(1 + rate, n)) * rate / (factor * (pow(1 + rate, n) - 1))
    }
    
    func calculateInterestRate(P: Double, PMT: Double, A: Double, n: Double, pmtAt: PaymentDue = .end) -> Double? {
        var guess = 0.01
        let tolerance = 1e-6
        var iterations = 0
        
        while iterations < 100 {
            let rate = guess / 12
            let calculatedA = P * pow(1 + rate, n) + PMT * ((pow(1 + rate, n) - 1) / rate)
            let f = calculatedA - A
            let df = P * n * pow(1 + rate, n - 1) + PMT * ((n * pow(1 + rate, n - 1)) / rate - ((pow(1 + rate, n) - 1) / pow(rate, 2)))
            
            let newGuess = guess - f/df
            if abs(newGuess - guess) < tolerance {
                return newGuess * 100
            }
            guess = newGuess
            iterations += 1
        }
        return nil
    }
}
