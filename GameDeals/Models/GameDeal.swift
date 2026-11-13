struct GameDeal: Decodable, Identifiable {
    var id: String { dealID }
    
    let dealID: String
    let title: String
    let storeID: String
    let salePrice: String
    let normalPrice: String
    let savigs: String
    let thumb: String
    
    var discountPercentage: Int {
        Int(Double(savigs) ?? 0)
    }
}
