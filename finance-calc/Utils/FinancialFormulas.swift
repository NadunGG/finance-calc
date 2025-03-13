import Foundation

struct FinancialFormulas {
    /// Calculate (A)
    static func calculateFutureValue(P: Double, r: Double, N: Double, CpY: Double) -> Double {
        return P * pow(1 + (r / CpY), N * CpY)
    }
    
    /// Calculate (P)
    static func calculatePresentValue(A: Double, r: Double, N: Double, CpY: Double) -> Double {
        return A / pow(1 + (r / CpY), N * CpY)
    }
    
    /// Calculate (N)
    static func calculateNumberOfPayments(P: Double, A: Double, r: Double, CpY: Double) -> Double {
        return log(A / P) / log(1 + (r / CpY)) / CpY
    }
    
    /// Estimate (r)
    static func estimateInterestRate(P: Double, A: Double, N: Double, CpY: Double, initialGuess: Double = 0.05) -> Double? {
        var r = initialGuess
        for _ in 0..<100 {
            let f = P * pow(1 + r / CpY, N * CpY) - A
            let fPrime = (N * CpY * P * pow(1 + r / CpY, N * CpY - 1)) / CpY
            let newR = r - f / fPrime
            if abs(newR - r) < 1e-6 { return newR }
            r = newR
        }
        return nil
    }
    
    /// Calculate (PMT)
    static func calculatePayment(P: Double, r: Double, N: Double, CpY: Double) -> Double {
        let monthlyRate = r / CpY
        return (P * monthlyRate) / (1 - pow(1 + monthlyRate, -N * CpY))
    }
}
