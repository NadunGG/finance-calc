import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationStack{
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
            }
            .navigationTitle("Financial Calculator")
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
