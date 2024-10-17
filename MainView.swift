import SwiftUI

struct MainView: View {
    @Binding var selectedTab: Tab?
    @Binding var isMenuVisible: Bool?
    @Binding var isLoggedIn: Bool
    @State private var isDarkMode: Bool = false
    @State private var isMenuAnimating: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HeaderView(
                        selectedTab: Binding(
                            get: { selectedTab ?? .home },
                            set: { selectedTab = $0 }
                        ),
                        isMenuVisible: Binding(
                            get: { isMenuVisible ?? false },
                            set: { isMenuVisible = $0 }
                        ),
                        isDarkMode: $isDarkMode
                    )

                    if selectedTab == .home {
                        HomeView(
                            selectedTab: Binding(
                                get: { selectedTab ?? .home },
                                set: { selectedTab = $0 }
                            ),
                            isMenuVisible: Binding(
                                get: { isMenuVisible ?? false },
                                set: { isMenuVisible = $0 }
                            )
                        )
                    } else if selectedTab == .market {
                        MarketDataView(
                            selectedTab: Binding(
                                get: { selectedTab ?? .home },
                                set: { selectedTab = $0 }
                            ),
                            isMenuVisible: Binding(
                                get: { isMenuVisible ?? false },
                                set: { isMenuVisible = $0 }
                            )
                        )
                    }
                }
                .background(isDarkMode ? Color.white : Color.black)
                .environment(\.isDarkMode, isDarkMode)

                if isMenuVisible == true || isMenuAnimating {
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isMenuAnimating = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isMenuVisible = false
                                isMenuAnimating = false
                            }
                        }

                    MenuView(isMenuVisible: $isMenuVisible, isLoggedIn: $isLoggedIn, isDarkMode: $isDarkMode)
                        .frame(maxWidth: .infinity, alignment: .bottom)
                        .offset(y: isMenuAnimating ? 600 : 300)
                        .animation(.easeInOut(duration: 0.3), value: isMenuAnimating)
                        .edgesIgnoringSafeArea(.bottom)
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}
