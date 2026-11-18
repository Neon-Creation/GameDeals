import Foundation

struct ITADDealsResponseDTO: Decodable, Sendable {
    let list: [ITADGameItemDTO]
}

struct ITADGameItemDTO: Decodable, Sendable {
    let id: String
    let title: String
    let assets: ITADAssetsDTO?
    let deal: ITADDealDetailsDTO?
    
    func toDomain(stores: [StoreDeal]) -> GameDeal {
        let sale = deal?.price?.amount ?? 0.0
        let regular = deal?.regular?.amount ?? 0.0
        let discount = deal?.cut ?? 0
        let store = deal?.shop?.name ?? ""
        let image = assets?.preferredImageURL ?? ""

        return GameDeal(
            dealID: id,
            title: title,
            thumb: image,
            bestStoreName: store,
            salePrice: String(format: "%.2f", sale),
            normalPrice: String(format: "%.2f", regular),
            savings: discount,
            stores: stores
        )
    }
}
                                                                                                                                                                                       
struct ITADAssetsDTO: Decodable, Sendable {
    let boxart: String?
    let banner145: String?
    let banner300: String?
    let banner400: String?
                                                                                                                                                                                       
    var preferredImageURL: String {
        banner300 ?? banner400 ?? banner145 ?? boxart ?? ""
    }
}
                                                                                                                                
struct ITADDealDetailsDTO: Decodable, Sendable {
    let shop: ITADShopDTO?
    let price: ITADPriceDTO?
    let regular: ITADPriceDTO?
    let cut: Int?
}
                                                                                                                                                                                       
struct ITADShopDTO: Decodable, Sendable {
    let name: String
}
                                                                                                                                                                                       
struct ITADPriceDTO: Decodable, Sendable {
    let amount: Double
}

struct ITADPricesResponseItemDTO: Decodable, Sendable {
    let id: String
    let deals: [ITADDealDetailsDTO]
    
    func toStoreDeals() -> [StoreDeal] {
        deals.map { deal in
            StoreDeal(
                storeName: deal.shop?.name ?? "",
                salePrice: String(format: "%.2f", deal.price?.amount ?? 0.0),
                normalPrice: String(format: "%.2f", deal.regular?.amount ?? 0.0),
                savings: deal.cut ?? 0
            )
        }
    }
}
