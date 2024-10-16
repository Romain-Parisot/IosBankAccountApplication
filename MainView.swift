import SwiftUI

struct MainView: View {
    @State private var selectedTab: Tab = .home // Default to Home tab
    @State private var isMenuVisible = false
    @State private var isDarkMode = false

    var body: some View {
        VStack {
            HeaderView(selectedTab: $selectedTab, isMenuVisible: $isMenuVisible, isDarkMode: isDarkMode)

            // Display the selected view based on the tab
            switch selectedTab {
            case .home:
                HomeView(isMenuVisible: $isMenuVisible, isDarkMode: isDarkMode) // Pass the necessary bindings
            case .market:
                MarketDataView() // No need to pass bindings unless necessary
            }
        }
        .background(isDarkMode ? Color.black : Color.white) // Set background based on dark mode
        .environment(\.isDarkMode, isDarkMode) // Pass dark mode state to the environment
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
