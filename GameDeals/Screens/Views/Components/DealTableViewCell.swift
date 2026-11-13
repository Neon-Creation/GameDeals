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
        customContainer.fillSafeArea()
    }
    
    private func styleListConfig() {
        selectionStyle = .default
        accessoryType = .disclosureIndicator
        backgroundColor = .clear
    }
    
    func configure(
        gameImage: UIImage?,
        gameName: String?,
        offPercentage: Int?,
        shopName: String?,
        currentGamePrice: Double?
    ) {
        customContainer
            .configure(
                gameImage: gameImage,
                gameName: gameName,
                offPercentage: offPercentage,
                shopName: shopName,
                currentGamePrice: currentGamePrice
            )
    }
    
    func configure(
        shopImage: UIImage?,
        shopName: String,
        status: Bool
    ) {
        customContainer
            .configure(shopImage: shopImage, shopName: shopName, status: status)
    }
}
