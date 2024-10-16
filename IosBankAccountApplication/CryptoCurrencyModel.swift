import Foundation

struct CryptoCurrency: Identifiable, Decodable {
    let id: Int
    let name: String
    let symbol: String
    let quote: Quote

    struct Quote: Decodable {
        let USD: PriceData
    }

    struct PriceData: Decodable {
        let price: Double
        let market_cap: Double
        let percent_change_24h: Double
    }
}
