import Foundation

enum ITADEndpoint {
    case deals(sortBy: SortOption, limit: Int = 30)
    case prices(ids: [String])
    
    private var scheme: String { "https" }
    private var host: String { "api.isthereanydeal.com" }
    
    private var path: String {
        switch self {
        case .deals:
            return "/deals/v2"
        case .prices:
            return "/games/prices/v2"
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .deals(let sortBy, let limit):
            return [
                URLQueryItem(name: "country", value: Locale.current.region?.identifier ?? "BR"),
                URLQueryItem(name: "sort", value: sortBy.itadSortParam),
                URLQueryItem(name: "limit", value: String(limit)),
            ]
        case .prices:
            return [
                URLQueryItem(name: "country", value: Locale.current.region?.identifier ?? "BR")
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        let apiKey = AppEnvironment.itadApiKey
        
        guard !apiKey.isEmpty else {
            throw NetworkError.missingAPIKey
        }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "ITAD-API-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 15
        
        switch self {
        case .deals:
            request.httpMethod = "GET"
        case .prices(let ids):
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(ids)
        }
        
        return request
    }
}
