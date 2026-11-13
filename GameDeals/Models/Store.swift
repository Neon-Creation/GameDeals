import Foundation

struct Store: Decodable, Identifiable {
    var id: String { storeID }
    
    let storeID: String
    let storeNmae: String
    let isActive: Int
    let images: StoreImages
    
    var active: Bool {
        isActive == 1
    }
}

struct StoreImages: Decodable {
    let banner: String
    let logo: String
    let icon: String
}
