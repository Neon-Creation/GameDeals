import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(Error)
}

final class CheapSharksService {
    static let shared = CheapSharksService()
    private let baseURL = "https://www.cheapshark.com/api/1.0"
    
    func fetchDeals(
        storeID: String? = nil,
        upperPrice: Double? = nil,
        sortBy: String? = "Savings"
    ) async throws -> [GameDeal] {
        var urlComponents = URLComponents(string: "\(baseURL)/deals")
        var queryItems: [URLQueryItem] = []
        
        if let storeID = storeID {
            queryItems.append(URLQueryItem(name: "storeID", value: storeID))
        }
        
        if let upperPrice = upperPrice {
            queryItems.append(URLQueryItem(name: "upperPrice", value: String(upperPrice)))
        }
        
        if let sortBy = sortBy {
            queryItems.append(URLQueryItem(name: "sortBy", value: sortBy))
        }
        
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue("GameDealsApp/1.0 (IOS)", forHTTPHeaderField: "User-Agent")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Falha na resposta do servidor" as! Error)
        }
        
        do {
            return try JSONDecoder().decode([GameDeal].self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    func fetchStores() async throws -> [Store] {
        guard let url = URL(string: "\(baseURL)/stores") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError("Falha na resposta do servidor" as! Error)
        }
        
        do {
            return try JSONDecoder().decode([Store].self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
