import Foundation

struct FinancialParameters {
    var N: Double?  // Number of payments
    var r: Double?  // Interest rate as a decimal
    var P: Double?  // Present value (Initial Investment / Loan Amount)
    var PMT: Double? // Payment per period
    var A: Double?  // Future value
    var PayPY: Double = 12  // Payments per year
    var CpY: Double = 12  // Compounds per year
    var PmtAt: Int = 0  // Payment at 0 = End, 1 = Beginning
}


