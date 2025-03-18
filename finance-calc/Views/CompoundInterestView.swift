import SwiftUI

struct CompoundInterestView: View {
    @StateObject private var viewModel = CompoundInterestViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Compound Interest Calculation")) {
                Picker("Calculation Type", selection: $viewModel.selectedCalculation) {
                    ForEach(CompoundInterestViewModel.CalculationType.allCases, id: \ .self) { value in
                        Text(value.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if viewModel.selectedCalculation != .presentValue {
                    TextField("Initial Investment (P)", text: $viewModel.presentValue)
                        .keyboardType(.decimalPad)
                }

                if viewModel.selectedCalculation != .futureValue {
                    TextField("Future Value (A)", text: $viewModel.futureValue)
                        .keyboardType(.decimalPad)
                }

                if viewModel.selectedCalculation != .interestRate {
                    TextField("Interest Rate (%r)", text: $viewModel.interestRate)
                        .keyboardType(.decimalPad)
                }

                if viewModel.selectedCalculation != .numberOfYears {
                    TextField("Number of Years (N)", text: $viewModel.numberOfYears)
                        .keyboardType(.decimalPad)
                }
                
                Button("Calculate") {
                    viewModel.calculate()
                }
            }
            
            if let result = viewModel.result {
                Section(header: Text("Result")) {
                    Text(result)
                        .font(.headline)
                }
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Compound Interest")
    }
}

struct CompoundInterestView_Previews: PreviewProvider {
    static var previews: some View {
        CompoundInterestView()
    }
}
