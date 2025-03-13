import Foundation

class HelpViewModel: ObservableObject {
    @Published var helpText: String = "" 
    
    init() {
        loadHelpContent()
    }
    
    private func loadHelpContent() {
        helpText = """
        Welcome to the Financial Calculator App!
        
        This app helps you calculate:
        - Future Value of Investments
        - Present Value of Investments
        - Loan & Mortgage Payments
        - Number of Payments Required
        - Interest Rate Estimations
        
        Instructions:
        1. Choose the appropriate calculator.
        2. Enter your known values.
        3. Tap 'Calculate' to get your results.
        
        Note: Interest rates should be entered as percentages (e.g., 5 for 5%).
        """
    }
}
