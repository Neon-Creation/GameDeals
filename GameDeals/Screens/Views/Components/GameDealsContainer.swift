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
            title: gameName,
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
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.small),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.small),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.standard),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.standard),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 76)
        ])
    }
    
    func updateImage(_ image: UIImage?) {
        self.imageCard.image = image
    }
    
    // MARK: SOBRECARGA DO COMPONENTE
    func configure(
        gameImage: UIImage?,
        title: String?,
        offPercentage: Int?,
        shopName: String?,
        currentGamePrice: Double?
    ) {
        gameNameLabel.text = title
        
        if let percentage = offPercentage, let shopName = shopName {
            offPercentageAndShopLabel.isHidden = false
            offPercentageAndShopLabel.text = "\(shopName) • -\(percentage)%"
        } else {
            offPercentageAndShopLabel.isHidden = true
        }
        
        if let gameImage = gameImage {
            imageCard.image = gameImage
            imageCard.contentMode = .scaleAspectFill
        }
        
        if let currentGamePrice = currentGamePrice {
            if currentGamePrice != 0 {
                priceLabel.text = currentGamePrice.formattedCurrency()
            } else {
                priceLabel.text = "Gratis"
            }
        }
    }
    
    func configure(
        shopImage: UIImage?,
        shopName: String,
        status: Bool
    ) {
        configure(
            gameImage: shopImage,
            title: shopName,
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
        image.translatesAutoresizingMaskIntoConstraints = false

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
