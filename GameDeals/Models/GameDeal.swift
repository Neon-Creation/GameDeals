struct GameDeal: Identifiable {
    var id: String { dealID }
    
    let dealID: String
    let title: String
    let thumb: String

    let bestStoreName: String
    let salePrice: String
    let normalPrice: String
    let savings: Int
    
    let stores: [StoreDeal]
    
}
