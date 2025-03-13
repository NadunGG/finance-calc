import SwiftUI

struct HomeView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns:columns, spacing: 40) {
                    NavigationLink(destination: CompoundInterestView()) {
                        MenuBoxView(title: "Compound Interest", icon: "dollarsign.circle")
                    }
                    
                    NavigationLink(destination: SavingsView()) {
                        MenuBoxView(title: "Savings", icon: "chart.bar.fill")
                    }
                    
                    NavigationLink(destination: LoanView()) {
                        MenuBoxView(title: "Loan Calculator", icon: "creditcard.fill")
                    }
                    
                    NavigationLink(destination: MortgageView()) {
                        MenuBoxView(title: "Mortgage Calculator", icon: "house.fill")
                    }
                    
                    NavigationLink(destination: HelpView()) {
                        MenuBoxView(title: "Help & Instructions", icon: "questionmark.circle.fill")
                    }
                }
                .padding()
            }
        }
    }
}

struct MenuBoxView: View {
    let title: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.leading, 8)
        }
        .padding()
        .frame(width: 150, height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

