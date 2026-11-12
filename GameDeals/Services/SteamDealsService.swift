import Foundation

struct SteamDealsService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchDeals() async throws -> [SteamDeal] {
        guard var components = URLComponents(string: "https://store.steampowered.com/api/featuredcategories") else {
            throw SteamDealsError.invalidURL
        }

        components.queryItems = [
            URLQueryItem(name: "cc", value: "br"),
            URLQueryItem(name: "l", value: "portuguese")
        ]

        guard let url = components.url else {
            throw SteamDealsError.invalidURL
        }

        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw SteamDealsError.invalidResponse
        }
        guard (200..<300).contains(response.statusCode) else {
            throw SteamDealsError.httpStatus(response.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let featured = try decoder.decode(FeaturedCategories.self, from: data)
        return featured.specials.items
            .filter { $0.discountPercent > 0 }
    }
}

private struct FeaturedCategories: Decodable {
    let specials: FeaturedCategory
}

private struct FeaturedCategory: Decodable {
    let items: [SteamDeal]
}

private enum SteamDealsError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "O endereço das promoções é inválido."
        case .invalidResponse:
            return "A Steam retornou uma resposta inválida."
        case .httpStatus(let statusCode):
            return "A Steam respondeu com o código \(statusCode)."
        }
    }
}
