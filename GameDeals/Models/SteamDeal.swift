import Foundation

struct SteamDeal: Decodable, Identifiable {
    let id: Int
    let name: String
    let discountPercent: Int
    let finalPrice: Int?
    let currency: String?
    let headerImage: URL?

    var storeURL: URL {
        URL(string: "https://store.steampowered.com/app/\(id)")!
    }

    var formattedPrice: String {
        guard let finalPrice else {
            return "Preço indisponível"
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.currencyCode = currency ?? "BRL"

        return formatter.string(from: NSNumber(value: Double(finalPrice) / 100))
            ?? "Preço indisponível"
    }
}
