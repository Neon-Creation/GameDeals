import UIKit

class DealTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DealTableViewCell"

    private let gameImage: UIImage?
    private let gameName: String
    private let offPercentage: Int
    private let shopName: String
    private let currentGamePrice: String
    
    init(gameImage: UIImage, gameName: String, offPercentage: Int, shopName: String, currentGamePrice: String) {
        self.gameImage = gameImage
        self.gameName = gameName
        self.offPercentage = offPercentage
        self.shopName = shopName
        self.currentGamePrice = currentGamePrice
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        gameImageCard.image = gameImage
        gameNameLabel.text = gameName
        priceAndShopLabel.text = "\(shopName) • -\(offPercentage)%"
        priceLabel.text = currentGamePrice
        
        addSubview(mainStack)
        
        mainStack.fillSuperView()
    }

    func setGameImage(_ image: UIImage?) {
        gameImageCard.image = image
    }

    private lazy var mainStack: CustomStack = {
        let stack = CustomStack(
            axis: .horizontal,
            arrangedSubViews: [
                gameImageCard,
                stackedLabels,
                priceLabel
            ],
            spacing: Spacing.medium,
            alignment: .center
        )
        return stack
    }()
    
    private let gameImageCard: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
                
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        return image
    }()
    
    private lazy var stackedLabels: CustomStack = {
        let stack = CustomStack(
            axis: .vertical,
            arrangedSubViews: [
                gameNameLabel,
                priceAndShopLabel
            ],
            spacing: 4,
            alignment: .leading
        )
                
        return stack
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        return label
    }()
    
    private let priceAndShopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGreen
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        return label
    }()
}
