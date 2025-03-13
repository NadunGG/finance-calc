import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill"){
                HomeView()
            }
            Tab("Compound", systemImage: "dollarsign.circle"){
                CompoundInterestView()
            }
            Tab("Savings", systemImage: "chart.bar.fill"){
                SavingsView()
            }
            Tab("Loan", systemImage: "creditcard.fill"){
                LoanView()
            }
            Tab("Mortgage", systemImage: "house.fill"){
                MortgageView()
            }
            Tab("Help", systemImage: "questionmark.circle.fill"){
                MortgageView()
            }
            
        }
    }
}

#Preview {
    MainTabView()
}
