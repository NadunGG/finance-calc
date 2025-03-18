import Foundation

struct MortgageCalculator {
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
}
