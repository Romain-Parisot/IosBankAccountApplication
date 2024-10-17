import SwiftUI

struct TransactionsView: View {
    @Environment(\.isDarkMode) private var isDarkMode
    let transactionsByDate: [Date: [Transaction]] = generateRandomTransactions()

    var body: some View {
        List {
            ForEach(transactionsByDate.keys.sorted(by: >), id: \.self) { date in
                Section(header: Text(dateFormatted(date))) {
                    ForEach(transactionsByDate[date]!) { transaction in
                        HStack {
                            Image(systemName: transaction.category.icon)
                                .foregroundColor(transactionColor(for: transaction.amount))
                            Text(transaction.category.rawValue)
                                .foregroundColor(isDarkMode ? .black : .white)
                            
                            Spacer()
                            
                            Text(String(format: "$%d", transaction.amount))
                                .foregroundColor(transactionColor(for: transaction.amount))
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(isDarkMode ? Color.white : Color.black)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(isDarkMode ? Color.white : Color.black)
        .navigationBarTitle("All Transactions", displayMode: .inline)
        .foregroundColor(isDarkMode ? .black : .white)
    }

    private func dateFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
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

// Function to generate random transactions
func generateRandomTransactions() -> [Date: [Transaction]] {
    let categories: [TransactionCategory] = TransactionCategory.allCases
    var transactionsByDate: [Date: [Transaction]] = [:]

    let startDate = Date().addingTimeInterval(-30 * 24 * 60 * 60) // one month ago
    let randomDays = (0..<30).map { _ in Int.random(in: 0...10) }

    for day in 0..<30 {
        let date = Calendar.current.date(byAdding: .day, value: day, to: startDate)!
        let transactionCount = randomDays[day]

        for _ in 0..<transactionCount {
            let amount = Int.random(in: -1000...1000)
            let category = categories.randomElement()!
            let transaction = Transaction(amount: amount, category: category, date: date)

            transactionsByDate[date, default: []].append(transaction)
        }
    }

    return transactionsByDate
}



#Preview {
    TransactionsView()
}
