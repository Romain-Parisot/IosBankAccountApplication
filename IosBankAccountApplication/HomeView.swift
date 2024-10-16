import SwiftUI

struct HomeView: View {
    @State private var isMenuVisible = false
    @State private var dragOffset = CGSize.zero
    @State private var menuHeight: CGFloat = 150
    @State private var isDarkMode = false

    // Generate random transactions
    let transactions: [Int] = (0..<3).map { _ in Int.random(in: -1000...1000) }

    // Define primary and secondary colors
    private var primaryColor: Color {
        isDarkMode ? .black : .white
    }

    private var secondaryColor: Color {
        isDarkMode ? .white : .black
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 20) {
                // Header with logo and profile button
                HStack {
                    Image(isDarkMode ? "TradeRepublicLogo" : "TradeRepublicLogo2")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .padding(.leading, 16)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            isMenuVisible.toggle()
                        }
                    }) {
                        Text("R")
                            .font(.headline)
                            .frame(width: 40, height: 40)
                            .background(primaryColor.opacity(0.3))
                            .clipShape(Circle())
                            .foregroundColor(primaryColor)
                            .padding(.trailing, 16)
                    }
                }

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
                            if dragOffset.height > 50 {
                                // If dragged down enough, close the menu
                                withAnimation {
                                    isMenuVisible = false
                                    dragOffset = .zero
                                }
                            } else {
                                // Snap back to original position
                                withAnimation {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: isMenuVisible) // Smooth animation
            }
        }
    }

    // Function to determine the color of the transaction text
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

struct AllTransactionsView: View {
    var body: some View {
        Text("All Transactions Page")
            .foregroundColor(.white)
            .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    HomeView()
}
