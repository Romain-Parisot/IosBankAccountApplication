import SwiftUI

// Define a shared Tab enum
enum Tab {
    case home, market
}

struct HomeView: View {
    @State private var isMenuVisible = false
    @State private var dragOffset = CGSize.zero
    @State private var menuHeight: CGFloat = 150
    @State private var isDarkMode = false
    @State private var selectedTab: Tab = .home

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
        let maxAmount = max(income, spending, investing) // Find the maximum amount
        let scaleFactor = maxSize / CGFloat(maxAmount) // Calculate scale factor based on max size
        let calculatedSize = CGFloat(amount) * scaleFactor // Calculate the circle size

        // Ensure that the size is within the specified limits
        if calculatedSize < minSize {
            return minSize // Return the minimum size if calculated size is smaller
        } else if calculatedSize > maxSize {
            return maxSize // Ensure the size does not exceed max size
        }
        return calculatedSize // Return calculated size
    }

    var body: some View {
        NavigationView { // Wrap in NavigationView
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 20) {
                    // Header with logo and profile button
                    HeaderView(selectedTab: $selectedTab, isMenuVisible: $isMenuVisible, isDarkMode: isDarkMode)

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
                            Spacer() // Pushes the cash amount to the center
                            Text("$10,000")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(primaryColor)
                            Spacer() // Ensures the cash amount is centered
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)

                    // Expense, income, investment section
                    Text("Wallet Visualizer")
                        .font(.headline)
                        .foregroundColor(primaryColor)
                        .padding(.horizontal, 16)
                    GeometryReader { geometry in
                        let maxCircleSize: CGFloat = 140 // Set the maximum size for the largest circle
                        let minCircleSize: CGFloat = maxCircleSize / 2 // Set the minimum size for the circles
                        let incomeSize = circleSize(for: income, maxSize: maxCircleSize, minSize: minCircleSize)
                        let spendingSize = circleSize(for: spending, maxSize: maxCircleSize, minSize: minCircleSize)
                        let investingSize = circleSize(for: investing, maxSize: maxCircleSize, minSize: minCircleSize)

                        ZStack {
                            // Income Circle
                            Circle()
                                .fill(Color.green)
                                .frame(width: incomeSize, height: incomeSize)
                                .overlay(
                                    VStack {
                                        Spacer() // Pushes text to center vertically
                                        Text("Income")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center) // Center align the text
                                        Text("\(income)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center) // Center align the text
                                        Spacer() // Pushes text to center vertically
                                    }
                                )
                                .position(x: geometry.size.width / 2, y: geometry.size.height * 0.3)

                            // Spending Circle
                            Circle()
                                .fill(Color.red)
                                .frame(width: spendingSize, height: spendingSize)
                                .overlay(
                                    VStack {
                                        Spacer()
                                        Text("Expenses")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center) // Center align the text
                                        Text("\(spending)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center) // Center align the text
                                        Spacer()
                                    }
                                )
                                .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.7)

                            // Investing Circle
                            Circle()
                                .fill(Color.blue)
                                .frame(width: investingSize, height: investingSize)
                                .overlay(
                                    VStack {
                                        Spacer()
                                        Text("Investments")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center) // Center align the text
                                        Text("\(investing)")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center) // Center align the text
                                        Spacer()
                                    }
                                )
                                .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.7)
                        }
                        .frame(maxHeight: 120) // Set a max height for the circle section
                        .padding(.horizontal, 16) // Add horizontal padding
                    }

                    // Transactions section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Transactions")
                            .font(.headline)
                            .foregroundColor(primaryColor)

                        // List of recent transactions (max 3)
                        ForEach(transactions.indices, id: \.self) { index in
                            HStack {
                                Text("Transaction \(index + 1)")
                                    .font(.body)
                                    .foregroundColor(primaryColor)

                                Spacer()

                                // Display transaction amount with color based on value
                                Text(String(format: "$%d", transactions[index]))
                                    .font(.body)
                                    .foregroundColor(transactionColor(for: transactions[index]))
                            }
                        }

                        // Button to view all transactions
                        NavigationLink(destination: TransactionsView().environment(\.isDarkMode, isDarkMode)) {
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

                        // Card showing interest earned
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
                .background(secondaryColor.edgesIgnoringSafeArea(.all)) // Use secondary color for background
                .navigationBarBackButtonHidden(true)
                .environment(\.isDarkMode, isDarkMode) // Set the environment value for dark mode

                // Sliding Menu
                if isMenuVisible {
                    VStack {
                        // Menu options
                        VStack(spacing: 16) {
                            Button("Option 1") {
                                // Action for Option 1
                            }
                            Button("Option 2") {
                                // Action for Option 2
                            }
                            HStack {
                                Image(systemName: "moon.fill")
                                    .foregroundColor(secondaryColor)
                                    .frame(width: 24, height: 24)

                                Button("Dark mode") {
                                    withAnimation {
                                        isDarkMode.toggle()
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(primaryColor)
                        .foregroundColor(secondaryColor)
                        .cornerRadius(12)
                    }
                    .frame(width: UIScreen.main.bounds.width - 16, height: menuHeight)
                    .background(primaryColor)
                    .cornerRadius(12)
                    .offset(y: dragOffset.height)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Update the drag offset while dragging
                                dragOffset = value.translation
                            }
                            .onEnded { value in
                                if value.translation.height < -100 {
                                    // Hide the menu if dragged up enough
                                    withAnimation {
                                        isMenuVisible = false
                                    }
                                }
                                dragOffset = .zero // Reset drag offset
                            }
                    )
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }

    // Function to determine the color of the transaction based on the amount
    private func transactionColor(for amount: Int) -> Color {
        amount < 0 ? .red : .green
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


