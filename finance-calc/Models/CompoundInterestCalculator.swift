struct CompoundInterestCalculator {
    func calculateFutureValue(P: Double, r: Double, n: Double, CpY: Double = 12) -> Double {
        let periodicRate = r / 100 / CpY
        return P * pow(1 + periodicRate, n * CpY)
    }
    
    func calculatePresentValue(A: Double, r: Double, n: Double, CpY: Double = 12) -> Double {
        let periodicRate = r / 100 / CpY
        return A / pow(1 + periodicRate, n * CpY)
    }
    
    func calculateNumberOfYears(P: Double, A: Double, r: Double, CpY: Double = 12) -> Double? {
        let periodicRate = r / 100 / CpY
        return log(A/P) / (CpY * log(1 + periodicRate))
    }
    
    func calculateInterestRate(P: Double, A: Double, n: Double, CpY: Double = 12) -> Double? {
        let periodicRate = pow(A/P, 1/(n * CpY)) - 1
        return periodicRate * CpY * 100
    }
}
