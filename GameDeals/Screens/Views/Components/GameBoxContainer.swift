import UIKit

class GameBoxContainer: UIView {
    
    private let gameImage: UIImage
    private let gameName: String
    private let offPercentage: Int
    private let shopName: String
    private let currentGamePrince: Double
    
    init(gameImage: UIImage, gameName: String, offPercentage: Int, shopName: String, currentGamePrince: Double) {
        self.gameImage = gameImage
        self.gameName = gameName
        self.offPercentage = offPercentage
        self.shopName = shopName
        self.currentGamePrince = currentGamePrince
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        gameNameLabel.text = gameName
        priceAndShopLabel.text = "\(shopName) • -\(offPercentage)%"
        priceLabel.text = String(format: "R$ %.2f", currentGamePrince)
        
        addSubview(mainStack)
        
        mainStack.fillSuperView()
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
        image.backgroundColor = .red
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
                
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
        label.textColor = .black
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

#Preview {
    GameBoxContainer(gameImage: UIImage(named: "imageTest")!, gameName: "Helo", offPercentage: 10, shopName: "Steam", currentGamePrince: 11.9)
}
