import SwiftUI

struct MenuView: View {
    @Binding var isMenuVisible: Bool?
    @Binding var isLoggedIn: Bool
    @Binding var isDarkMode: Bool
    
    @State private var dragOffset: CGFloat = 0
    
    private var primaryColor: Color {
        isDarkMode ? .black : .white
    }

    private var secondaryColor: Color {
        isDarkMode ? .white : .black
    }

    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                print(isDarkMode)
                isMenuVisible = false
            }) {
                Text("Available on the next release")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .foregroundColor(primaryColor)
                    .background(.gray)
                    .cornerRadius(10)
            }
            .disabled(true)

            Button(action: {
                 isDarkMode.toggle()
                isMenuVisible = false

                 UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
             }) {
                 Text(isDarkMode ? "Disable Dark Mode" : "Enable Dark Mode")
                     .frame(maxWidth: .infinity)
                     .padding(.horizontal)
                     .padding(.vertical)
                     .foregroundColor(primaryColor)
                     .background(secondaryColor)
                     .cornerRadius(10)
             }

            Button(action: {
                isLoggedIn = false
                isMenuVisible = false
            }) {
                Text("Logout")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .foregroundColor(primaryColor)
                    .background(secondaryColor)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(height: 254)
        .background(primaryColor)
        .cornerRadius(16, corners: [.topLeft, .topRight]) // Rounded corners only at the top
        .shadow(radius: 10)
        .padding(.horizontal, 8)
        .offset(y: dragOffset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height > 0 { // Only allow dragging down
                        dragOffset = value.translation.height
                    }
                }
                .onEnded { value in
                    // Close the menu if dragged down enought
                    if value.translation.height > 100 {
                        withAnimation {
                            isMenuVisible = false
                        }
                    }
                    dragOffset = 0
                }
        )
        .transition(.move(edge: .bottom))
        .animation(.easeInOut, value: isMenuVisible)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = []

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
