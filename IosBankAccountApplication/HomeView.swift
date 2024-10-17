import SwiftUI

struct HomeView: View {
    @Environment(\.isDarkMode) private var isDarkMode
    @Binding var selectedTab: Tab?
    @Binding var isMenuVisible: Bool?
    @State private var dragOffset = CGSize.zero
    @State private var menuHeight: CGFloat = 150

    // Generate random transactions
    let transactions: [Int] = (0..<3).map { _ in Int.random(in: -1000...1000) }

    // Generate random values for income, spending, and investing
    let income: Int = Int.random(in: 1000...5000)
    let spending: Int = Int.random(in: 1000...3000)
    let investing: Int = Int.random(in: 500...2000)

    // Define primary and secondary colors
    private var primaryColor: Color {
        isDarkMode ? .black : .white
    }

    private var secondaryColor: Color {
        isDarkMode ? .white : .black
    }

    // Function to determine the size of the circles based on amounts
    private func circleSize(for amount: Int, maxSize: CGFloat, minSize: CGFloat) -> CGFloat {
        let maxAmount = max(income, spending, investing)
        let scaleFactor = maxSize / CGFloat(maxAmount)
        let calculatedSize = CGFloat(amount) * scaleFactor

        if calculatedSize < minSize {
            return minSize
        } else if calculatedSize > maxSize {
            return maxSize
        }
        return calculatedSize
    }

    var body: some View {
        ScrollView { // Make the view scrollable
            VStack(alignment: .leading, spacing: 20) {
                // Welcome message
                Text("Welcome back, Romain!")
                    .font(.title)
                    .foregroundColor(primaryColor)
                    .padding(.leading, 16)

                // Cash Available Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cash Available")
                        .font(.headline)
                        .foregroundColor(primaryColor)

                    HStack {
                        Spacer()
                        Text("$10,000")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(primaryColor)
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                // Expense, income, investment section
                Text("Wallet Visualizer")
                    .font(.headline)
                    .foregroundColor(primaryColor)
                    .padding(.horizontal, 16)
                    .padding(.top, 16) // Add space above

                GeometryReader { geometry in
                    let maxCircleSize: CGFloat = 140
                    let minCircleSize: CGFloat = maxCircleSize / 2
                    let incomeSize = circleSize(for: income, maxSize: maxCircleSize, minSize: minCircleSize)
                    let spendingSize = circleSize(for: spending, maxSize: maxCircleSize, minSize: minCircleSize)
                    let investingSize = circleSize(for: investing, maxSize: maxCircleSize, minSize: minCircleSize)

                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: incomeSize, height: incomeSize)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Text("Income")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    Text("\(income)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            )
                            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.3)

                        Circle()
                            .fill(Color.red)
                            .frame(width: spendingSize, height: spendingSize)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Text("Expenses")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    Text("\(spending)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            )
                            .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.7)

                        Circle()
                            .fill(Color.blue)
                            .frame(width: investingSize, height: investingSize)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Text("Investments")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                    Text("\(investing)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            )
                            .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.7)
                    }
                    .frame(maxHeight: 120)
                    .padding(.horizontal, 16)
                }
                .frame(height: 200) // Fixed height for the GeometryReader

                // Add space below the circles
                .padding(.bottom, 16)

                // Transactions section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Transactions")
                        .font(.headline)
                        .foregroundColor(primaryColor)

                    ForEach(transactions.indices, id: \.self) { index in
                        HStack {
                            Text("Transaction \(index + 1)")
                                .font(.body)
                                .foregroundColor(primaryColor)

                            Spacer()

                            Text(String(format: "$%d", transactions[index]))
                                .font(.body)
                                .foregroundColor(transactionColor(for: transactions[index]))
                        }
                    }

                    NavigationLink(destination: TransactionsView()) {
                        Text("View All Transactions")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                // Benefits section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Benefits")
                        .font(.headline)
                        .foregroundColor(primaryColor)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Interest Earned")
                            .font(.subheadline)
                            .foregroundColor(primaryColor)
                        Text("$150")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(primaryColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)

                Spacer()
            }
            .background(secondaryColor.edgesIgnoringSafeArea(.all))
        }
    }

    private func transactionColor(for amount: Int) -> Color {
        amount < 0 ? .red : .green
    }
}
