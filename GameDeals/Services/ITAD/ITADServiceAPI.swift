import Foundation

final class ITADServiceAPI: DealsServiceProtocol {
    static let shared = ITADServiceAPI()
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchDeals(sortBy: SortOption) async throws -> [GameDeal] {
        let endpoint = ITADEndpoint.deals(sortBy: sortBy)
        let request = try endpoint.asURLRequest()
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw NetworkError.requestFailed(error.localizedDescription)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse(statusCode: -1)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let dealsResponse = try decoder.decode(ITADDealsResponseDTO.self, from: data)
            
            let ids = dealsResponse.list.map { $0.id }
            let pricesReponse = try await fetchPrices(for: ids)
            
            let storeDict = Dictionary(uniqueKeysWithValues: pricesReponse.map { ($0.id, $0.toStoreDeals()) })
            
            return dealsResponse.list.map { item in
                item.toDomain(stores: storeDict[item.id] ?? [])
            }
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
    
    private func fetchPrices(for ids: [String]) async throws -> [ITADPricesResponseItemDTO] {
        let endpoint = ITADEndpoint.prices(ids: ids)
        let request = try endpoint.asURLRequest()
        let (data, response) = try await session.data(for: request)
        
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw NetworkError.invalidResponse(statusCode: -1)
        }
        
        return try JSONDecoder().decode([ITADPricesResponseItemDTO].self, from: data)
    }
}
