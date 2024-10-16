import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
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
                
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                
                Button(action: {
                    if email == "" && password == "" {
                        isLoggedIn = true
                        showError = false
                    } else {
                        showError = true
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

#Preview {
    LoginView()
}
