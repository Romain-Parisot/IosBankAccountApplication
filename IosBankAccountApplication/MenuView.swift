import SwiftUI

struct MenuView: View {
    @Binding var isMenuVisible: Bool?
    
    // State variable to handle dragging
    @State private var dragOffset: CGFloat = 0

    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                // Action for option 1
                print("Option 1 tapped")
                isMenuVisible = false // Close menu
            }) {
                Text("Option 1")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal) // Add horizontal padding for spacing
                    .padding(.vertical) // Optional vertical padding
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                // Action for option 2
                print("Option 2 tapped")
                isMenuVisible = false // Close menu
            }) {
                Text("Option 2")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal) // Add horizontal padding for spacing
                    .padding(.vertical) // Optional vertical padding
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                // Action for option 3
                print("Option 3 tapped")
                isMenuVisible = false // Close menu
            }) {
                Text("Option 3")
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal) // Add horizontal padding for spacing
                    .padding(.vertical) // Optional vertical padding
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(height: 254) // Fixed height for the menu
        .background(Color.gray.opacity(0.8))
        .cornerRadius(16, corners: [.topLeft, .topRight]) // Rounded corners only at the top
        .shadow(radius: 10)
        .padding(.horizontal, 8) // 8px from the sides
        .offset(y: dragOffset) // Adjust position based on drag offset
        .gesture(
            DragGesture()
                .onChanged { value in
                    // Update the drag offset based on the drag distance
                    if value.translation.height > 0 { // Only allow dragging down
                        dragOffset = value.translation.height
                    }
                }
                .onEnded { value in
                    // Close the menu if dragged down sufficiently
                    if value.translation.height > 100 { // Threshold to close
                        withAnimation {
                            isMenuVisible = false
                        }
                    }
                    // Reset the offset after dragging ends
                    dragOffset = 0
                }
        )
        .transition(.move(edge: .bottom))
        .animation(.easeInOut, value: isMenuVisible) // Animation based on visibility
    }
}

extension View {
    // Custom modifier to round specific corners
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorners(radius: radius, corners: corners))
    }
}

// Custom shape to round specific corners
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
