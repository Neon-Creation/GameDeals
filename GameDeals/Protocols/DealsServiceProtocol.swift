protocol DealsServiceProtocol {
    func fetchDeals(sortBy: SortOption) async throws -> [GameDeal]
}

enum SortOption: String, Sendable {
    case discount = "savings"
    case price = "price"
    case rating = "review"
    
    var itadSortParam: String {
        switch self {
        case .discount:
            return "-cut"
        case .price:
            return "price"
        case .rating: 
            return "-trending"
        }
    }
}
