import SwiftUI
  
struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated: Bool = false
    @State private var errorMessage: String?

    private let predefinedUsername = "Utilisateur"
    private let predefinedPassword = "motdepasse"

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Connexion")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)

                    TextField("Nom d'utilisateur", text: $username)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)

                    SecureField("Mot de passe", text: $password)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color.blue)
                        .cornerRadius(10)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Button(action: {
                        authenticateUser()
                    }) {
                        Text("Se connecter")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()

                    NavigationLink(destination: HomeView(), isActive: $isAuthenticated) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }

    private func authenticateUser() {
        if username == predefinedUsername && password == predefinedPassword {
            isAuthenticated = true
            errorMessage = nil
        } else {
            errorMessage = "Nom d'utilisateur ou mot de passe incorrect."
        }
    }
}

#Preview {
    ContentView()
}
