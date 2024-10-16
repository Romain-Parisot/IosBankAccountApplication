import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: Tab
    @Binding var isMenuVisible: Bool
    var isDarkMode: Bool

    var body: some View {
        VStack {
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
                        .background(Color.white.opacity(0.3))
                        .clipShape(Circle())
                        .foregroundColor(Color.black)
                        .padding(.trailing, 16)
                }
            }

            HStack {
                Button(action: {
                    selectedTab = .home // Set the selected tab to home
                }) {
                    Text("Home")
                        .font(.headline)
                        .foregroundColor(selectedTab == .home ? Color.black : Color.white)
                        .padding()
                        .background(selectedTab == .home ? Color.white : Color.clear)
                        .cornerRadius(10)
                }

                NavigationLink(destination: MarketDataView()) {
                    Text("Market")
                        .font(.headline)
                        .foregroundColor(selectedTab == .market ? Color.black : Color.white)
                        .padding()
                        .background(selectedTab == .market ? Color.white : Color.clear)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
