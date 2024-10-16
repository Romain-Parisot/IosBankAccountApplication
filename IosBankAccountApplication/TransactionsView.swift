import SwiftUI

struct TransactionsView: View {
    @Environment(\.isDarkMode) private var isDarkMode // Get the environment value
    let transactions: [Int] = (0..<100).map { _ in Int.random(in: -1000...1000) }

    var body: some View {
        VStack {
            // Transactions List
            List(transactions.indices, id: \.self) { index in
                HStack {
                    Text("Transaction \(index + 1)")
                        .foregroundColor(isDarkMode ? .black : .white) // Flipped color for dark mode

                    Spacer()

                    Text(String(format: "$%d", transactions[index]))
                        .foregroundColor(transactionColor(for: transactions[index]))
                }
                .padding(.vertical, 4)
                .listRowBackground(isDarkMode ? Color.white : Color.black) // Flipped row background based on dark mode
            }
            .scrollContentBackground(.hidden)
            .background(isDarkMode ? Color.white : Color.black) // Flipped background based on dark mode
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("All Transactions", displayMode: .inline)
        .foregroundColor(.white)
    }

    func transactionColor(for amount: Int) -> Color {
        if amount > 0 {
            return .green
        } else if amount < 0 {
            return .red
        } else {
            return .gray
        }
    }
}

#Preview {
    TransactionsView()
}
