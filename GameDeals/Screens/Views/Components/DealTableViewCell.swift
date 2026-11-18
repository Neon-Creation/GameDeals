import UIKit

class DealTableViewCell: UITableViewCell {
    static let reuseIdentifier = "DealTableViewCell"

    private let customContainer = GameDealsContainer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleListConfig()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(customContainer)
        customContainer.fillSuperView()
        customContainer.padding(Spacing.standard)
    }
    
    private func styleListConfig() {
        selectionStyle = .default
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
    }
    
    func configure(
        deal: GameDeal
    ) {
        let placeholderImage = UIImage(systemName: "gamecontroller.fill")
        
        customContainer
            .configure(
                gameImage: placeholderImage,
                title: deal.title,
                offPercentage: deal.savings,
                shopName: deal.bestStoreName,
                currentGamePrice: Double(deal.salePrice) ?? 0.0
            )
    }
    
    func configure(
        shopImage: UIImage?,
        shopName: String,
        status: Bool
    ) {
        let placeholderImage = UIImage(systemName: "bag.fill")
        
        customContainer
            .configure(shopImage: placeholderImage, shopName: shopName, status: status)
    }
    
    func setImage(_ image: UIImage?) {
        customContainer.updateImage(image)
    }
}
