import SwiftUI

struct MainView: View {
    @Binding var selectedTab: Tab?
    @Binding var isMenuVisible: Bool?
    @Environment(\.isDarkMode) private var isDarkMode

    @State private var isMenuAnimating: Bool = false // New state for controlling animation

    var body: some View {
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
                    isDarkMode: isDarkMode
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

            // MenuView
            if isMenuVisible == true || isMenuAnimating {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Start the animation
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isMenuAnimating = true
                        }

                        // Delay hiding the menu to allow the animation to complete
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Match this to the animation duration
                            isMenuVisible = false
                            isMenuAnimating = false // Reset the animation state
                        }
                    }

                MenuView(isMenuVisible: $isMenuVisible)
                    .frame(maxWidth: .infinity, alignment: .bottom)
                    .offset(y: isMenuAnimating ? 600 : 300) // Slide down animation
                    .animation(.easeInOut(duration: 0.3), value: isMenuAnimating) // Trigger animation based on isMenuAnimating
                    .edgesIgnoringSafeArea(.bottom) // Ensure it stays at the bottom
                    .transition(.move(edge: .bottom)) // Transition for the menu
            }
        }
    }
}
