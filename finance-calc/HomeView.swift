import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
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
            .navigationTitle("Financial Calculator")
        }
    }
}

struct MenuBoxView: View {
    let title: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.leading, 8)
            
            Spacer()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

#Preview {
    HomeView()
}
