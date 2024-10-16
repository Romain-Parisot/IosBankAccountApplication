import Foundation

class CryptoDataService: ObservableObject {
    @Published var cryptos: [CryptoCurrency] = []

    let apiKey = "ed8ec722-32cb-4487-bc7a-b622f1ba3efb"

    func fetchCryptoData() {
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=100&convert=USD") else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(String(describing: error))")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(CryptoResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.cryptos = decodedResponse.data
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }

        task.resume()
    }
}

struct CryptoResponse: Decodable {
    let data: [CryptoCurrency]
}
