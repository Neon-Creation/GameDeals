import Foundation

enum AppEnvironment {
    static var itadApiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "ITADApiKey") as? String,
              !key.isEmpty,
              !key.hasPrefix("$(") else {
            
            #if DEBUG
            print("[AVISO] Chave ITADApiKey não configurada no Info.plist ou Config.xcconfig ausente!")
            #endif
            
            return ""
        }
        
        return key
    }
}
