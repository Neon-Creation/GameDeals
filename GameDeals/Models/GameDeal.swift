struct GameDeal: Decodable, Identifiable {
    var id: String { dealID }
    
    let dealID: String
    let title: String
    let storeID: String
    let salePrice: String
    let normalPrice: String
    let savings: String
    let thumb: String
    
    var discountPercentage: Int {
        Int(Double(savings) ?? 0)
    }
}
