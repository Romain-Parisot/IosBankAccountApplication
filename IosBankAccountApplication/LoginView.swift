import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isLoggedIn: Bool = false
    @State private var selectedTab: Tab? = .home
    @State private var isMenuVisible: Bool? = false

    var body: some View {
        // Use NavigationStack outside of the LoginView
        if isLoggedIn {
            // When logged in, navigate directly to MainView without a back button
            MainView(selectedTab: $selectedTab, isMenuVisible: $isMenuVisible)
                .navigationBarBackButtonHidden(true) // Hide the back button
                .transition(.move(edge: .trailing))
        } else {
            NavigationStack {
                VStack(spacing: 40) {
                    Spacer()

                    Image("TradeRepublicLogo2")
                        .resizable()
                        .frame(width: 128, height: 128)

                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email :")
                                .foregroundColor(.white)
                                .font(.callout)

                            TextField("Enter your email", text: $email)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .foregroundColor(.black)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password :")
                                .foregroundColor(.white)
                                .font(.callout)

                            SecureField("Enter your password", text: $password)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 32)

                    // NavigationLink updated to pass parameters to MainView
                    NavigationLink(destination: MainView(selectedTab: $selectedTab, isMenuVisible: $isMenuVisible), isActive: $isLoggedIn) {
                        EmptyView()
                    }

                    Button(action: {
                        // Check if the email and password fields are filled
                        if email.isEmpty || password.isEmpty {
                            showError = true
                        } else {
                            isLoggedIn = true
                            showError = false
                        }
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 32)

                    if showError {
                        Text("Incorrect email or password")
                            .foregroundColor(.red)
                            .padding(.top, 20)
                    }

                    Spacer()
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
    }
}

#Preview {
    LoginView()
}
