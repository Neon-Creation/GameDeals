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
            let dtoResponse = try decoder.decode(ITADDealsResponseDTO.self, from: data)
            return dtoResponse.list.map {$0.toDomain()}
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
}
