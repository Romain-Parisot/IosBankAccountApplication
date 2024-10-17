import SwiftUI

struct CryptoCurrencyModel: Identifiable {
    let id = UUID()
    let name: String
    let symbol: String
    let price: Double
    let marketCap: Double
    let percentChange24h: Double
}

class CryptoDataService: ObservableObject {
    @Published var cryptos: [CryptoCurrencyModel]? = nil
    @Published var isLoading: Bool = false
    
    private let apiKey = "ed8ec722-32cb-4487-bc7a-b622f1ba3efb"
    
    func fetchCryptoData() {
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=100") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.httpMethod = "GET"
        
        self.isLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(CMCResponse.self, from: data)
                let cryptos = decodedResponse.data.map { crypto in
                    CryptoCurrencyModel(
                        name: crypto.name,
                        symbol: crypto.symbol,
                        price: crypto.quote.USD.price,
                        marketCap: crypto.quote.USD.marketCap,
                        percentChange24h: crypto.quote.USD.percentChange24h
                    )
                }
                
                DispatchQueue.main.async {
                    self.cryptos = cryptos
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
}

struct MarketDataView: View {
    @Environment(\.isDarkMode) private var isDarkMode
    @StateObject private var cryptoDataService = CryptoDataService()
    @Binding var selectedTab: Tab?
    @Binding var isMenuVisible: Bool?

    var body: some View {
        NavigationView {
            VStack {
                Text("Top 100 Cryptocurrencies")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .foregroundColor(isDarkMode ? .black : .white)
                    .multilineTextAlignment(.center)

                if cryptoDataService.isLoading {
                    ProgressView("Fetching Market Data...")
                        .font(.headline)
                        .padding()
                        .foregroundColor(isDarkMode ? .black : .white)
                } else if let cryptos = cryptoDataService.cryptos {
                    List(cryptos.prefix(100)) { crypto in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(crypto.name)
                                    .font(.headline)
                                    .foregroundColor(isDarkMode ? .black : .white)
                                Text(crypto.symbol)
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .black : .gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("$\(String(format: "%.2f", crypto.price))")
                                    .bold()
                                    .foregroundColor(isDarkMode ? .black : .white)
                                Text("Mkt Cap: $\(String(format: "%.0f", crypto.marketCap))")
                                    .font(.caption)
                                    .foregroundColor(isDarkMode ? .black : .gray)
                                Text("24h: \(String(format: "%.2f%%", crypto.percentChange24h))")
                                    .foregroundColor(crypto.percentChange24h > 0 ? .green : .red)
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 8)
                        .listRowBackground(isDarkMode ? Color.white : Color.black)
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("Failed to load market data")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            .background(isDarkMode ? Color.white : Color.black)
            .onAppear {
                cryptoDataService.fetchCryptoData()
            }
        }
        .navigationBarTitle("Market Data", displayMode: .inline)
    }
}

#Preview {
    Group {
        @State var isMenuVisible: Bool? = false
        
        MarketDataView(selectedTab: .constant(Tab.market), isMenuVisible: $isMenuVisible)
            .environment(\.isDarkMode, false)
        
        MarketDataView(selectedTab: .constant(Tab.market), isMenuVisible: $isMenuVisible)
            .environment(\.isDarkMode, true)
    }
}



struct CMCResponse: Codable {
    let data: [CryptoData]
}

struct CryptoData: Codable {
    let name: String
    let symbol: String
    let quote: Quote
}

struct Quote: Codable {
    let USD: USDQuote
}

struct USDQuote: Codable {
    let price: Double
    let marketCap: Double
    let percentChange24h: Double
    
    enum CodingKeys: String, CodingKey {
        case price
        case marketCap = "market_cap"
        case percentChange24h = "percent_change_24h"
    }
}
