import UIKit

class GameDealsContainer: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init(
        gameImage: UIImage?,
        gameName: String,
        offPercentage: Int?,
        shopName: String?,
        currentGamePrice: Double
    ) {
        self.init(frame: .zero)
        configure(
            gameImage: gameImage,
            gameName: gameName,
            offPercentage: offPercentage,
            shopName: shopName,
            currentGamePrice: currentGamePrice
        )
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(mainStack)
        mainStack.fillSuperView()
    }
    
    // MARK: SOBRECARGA DO COMPONENTE
    func configure(
        gameImage: UIImage?,
        gameName: String?,
        offPercentage: Int?,
        shopName: String?,
        currentGamePrice: Double?
    ) {
        imageCard.image = gameImage
        gameNameLabel.text = gameName
        
        if let percentage = offPercentage, let shopName = shopName {
            offPercentageAndShopLabel.isHidden = false
            offPercentageAndShopLabel.text = "\(shopName) • -\(percentage)%"
        } else {
            offPercentageAndShopLabel.isHidden = true
        }
        
        if let currentGamePrice = currentGamePrice {
            priceLabel.text = currentGamePrice.formattedCurrency()
        }
    }
    
    func configure(
        shopImage: UIImage?,
        shopName: String,
        status: Bool
    ) {
        configure(
            gameImage: shopImage,
            gameName: shopName,
            offPercentage: nil,
            shopName: nil,
            currentGamePrice: nil
        )
        priceLabel.text = status ? "Ativa" : "Desativada"
    }
    
    // MARK: COMPONENTES VISUAIS DO COMPONENTE

    private lazy var mainStack: CustomStack = {
        let stack = CustomStack(
            axis: .horizontal,
            arrangedSubViews: [
                imageCard,
                stackedLabels,
                priceLabel,
            ],
            spacing: Spacing.medium,
            alignment: .center
        )
        return stack
    }()

    private let imageCard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "gamecontroller.fill")
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 12

        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60),
        ])

        return image
    }()

    private lazy var stackedLabels: CustomStack = {
        let stack = CustomStack(
            axis: .vertical,
            arrangedSubViews: [
                gameNameLabel,
                offPercentageAndShopLabel,
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

    private let offPercentageAndShopLabel: UILabel = {
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

#Preview("1. Jogo em Promoção") {
    let view = GameDealsContainer()
    view.configure(
        gameImage: UIImage(systemName: "gamecontroller.fill"),
        gameName: "Hades II",
        offPercentage: 25,
        shopName: "Steam",
        currentGamePrice: 66.74
    )
    return view
}

#Preview("2. Loja Ativa (Sobrecarga 2)") {
    let view = GameDealsContainer()
    view.configure(
        shopImage: UIImage(systemName: "storefront.fill"),
        shopName: "Nuuvem",
        status: true
    )
    return view
}

#Preview("3. Loja Desativada (Sobrecarga 2)") {
    let view = GameDealsContainer()
    view.configure(
        shopImage: UIImage(systemName: "storefront"),
        shopName: "Epic Games",
        status: false
    )
    return view
}

#Preview("4. Todos Juntos") {
    let gameDeal = GameDealsContainer()
    gameDeal.configure(
        gameImage: UIImage(systemName: "gamecontroller.fill"),
        gameName: "Cyberpunk 2077",
        offPercentage: 50,
        shopName: "GOG",
        currentGamePrice: 99.90
    )
    
    let activeShop = GameDealsContainer()
    activeShop.configure(
        shopImage: UIImage(systemName: "bag.fill"),
        shopName: "Steam",
        status: true
    )
    
    let inactiveShop = GameDealsContainer()
    inactiveShop.configure(
        shopImage: UIImage(systemName: "bag"),
        shopName: "Origin",
        status: false
    )
    
    let stack = UIStackView(arrangedSubviews: [gameDeal, activeShop, inactiveShop])
    stack.axis = .vertical
    stack.spacing = 20
    stack.alignment = .fill
    stack.isLayoutMarginsRelativeArrangement = true
    stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    
    return stack
}
