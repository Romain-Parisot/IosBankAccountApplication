import SwiftUI

struct HeaderView: View {
    @Binding var selectedTab: Tab?
    @Binding var isMenuVisible: Bool?
    @Binding var isDarkMode: Bool
    
    private var primaryColor: Color {
        
        isDarkMode ? .white : .black
    }

    private var secondaryColor: Color {
        isDarkMode ? .black : .white
    }

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
                        isMenuVisible?.toggle()
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
                    selectedTab = .home
                }) {
                    Text("Home")
                        .font(.headline)
                        .foregroundColor(selectedTab == .home ? primaryColor : secondaryColor)
                        .padding()
                        .background(selectedTab == .home ? secondaryColor : primaryColor)
                        .cornerRadius(10)
                }

                Button(action: {
                    selectedTab = .market
                }) {
                    Text("Market")
                        .font(.headline)
                        .foregroundColor(selectedTab == .market ? primaryColor : secondaryColor)
                        .padding()
                        .background(selectedTab == .market ? secondaryColor : primaryColor)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 16)
        }
        .background(isDarkMode ? Color.white : Color.black)
    }
}
