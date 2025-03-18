struct LoanCalculator {
    enum PaymentDue { case beginning, end }
    
    func calculateMonthlyPayment(P: Double, r: Double, n: Double, pmtAt: PaymentDue = .end) -> Double {
        let monthlyRate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + monthlyRate) : 1.0
        
        return (P * monthlyRate) / (1 - pow(1 + monthlyRate, -n) * factor)
    }
    
    func calculateLoanAmount(PMT: Double, r: Double, n: Double, pmtAt: PaymentDue = .end) -> Double {
        let monthlyRate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + monthlyRate) : 1.0
        
        return PMT * (1 - pow(1 + monthlyRate, -n)) / (monthlyRate * factor)
    }
    
    func calculateNumberOfPayments(P: Double, PMT: Double, r: Double, pmtAt: PaymentDue = .end) -> Double? {
        let monthlyRate = r / 100 / 12
        let factor = pmtAt == .beginning ? (1 + monthlyRate) : 1.0
        
        return log(PMT * factor / (PMT * factor - P * monthlyRate)) / log(1 + monthlyRate)
    }
    
    func calculateInterestRate(P: Double, PMT: Double, n: Double, pmtAt: PaymentDue = .end) -> Double? {
        var guess = 0.01
        let tolerance = 1e-6
        var iterations = 0
        
        while iterations < 100 {
            let monthlyRate = guess / 12
            let numerator = P * monthlyRate
            let denominator = 1 - pow(1 + monthlyRate, -n)
            let factor = pmtAt == .beginning ? (1 + monthlyRate) : 1.0
            let calculatedPMT = numerator / (denominator * factor)
            
            let f = calculatedPMT - PMT
            let df = (P * (1 - pow(1 + monthlyRate, -n)) - P * monthlyRate * n * pow(1 + monthlyRate, -n - 1)) / pow(denominator * factor, 2)
            
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
