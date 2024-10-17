import Foundation

enum TransactionCategory: String, CaseIterable {
    case fuel = "Fuel"
    case restaurant = "Restaurant"
    case healthcare = "Health Care"
    case investments = "Investments"
    case transfer = "Virements"
    case shopping = "Shopping"
    case clothing = "Vetement"

    var icon: String {
        switch self {
        case .fuel: return "car.fill"
        case .restaurant: return "fork.knife"
        case .healthcare: return "cross.fill"
        case .investments: return "chart.bar"
        case .transfer: return "arrow.right.circle"
        case .shopping: return "cart.fill"
        case .clothing: return "tshirt"
        }
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    let amount: Int
    let category: TransactionCategory
    let date: Date
}
