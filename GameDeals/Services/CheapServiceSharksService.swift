import Foundation

final class CheapServiceSharksService {
    func fetch(completation: @escaping (Result<[GameDeal], Error>) -> Void) {
        
        guard let endpoint = URL(string: "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15") else {
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let games = try JSONDecoder().decode([GameDeal].self, from: data)
                completation(.success(games))
            } catch {
                completation(.failure(error))
            }
        }
        
        task.resume()
    }
}
