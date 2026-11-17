import Foundation
                                                            
enum NetworkError: LocalizedError, Sendable {
   case invalidURL
   case missingAPIKey
   case unauthorized
   case invalidResponse(statusCode: Int)
   case decodingError(String)
   case requestFailed(String)
   case noData
                                                                                                                                                                                      
   var errorDescription: String? {
       switch self {
       case .invalidURL:
           return "A URL da requisição é inválida."
       case .missingAPIKey:
           return "Chave de API não encontrada. Verifique seu Config.xcconfig."
       case .unauthorized:
           return "Chave de API não autorizada (401). Verifique suas credenciais da ITAD."
       case .invalidResponse(let statusCode):
           return "O servidor respondeu com status \(statusCode)."
       case .decodingError(let details):
           return "Falha ao processar os dados da API: \(details)"
       case .requestFailed(let details):
           return "Falha na conexão de rede: \(details)"
       case .noData:
           return "Nenhum dado retornado pelo servidor."
       }
   }
   
}
