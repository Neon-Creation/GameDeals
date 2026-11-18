import UIKit

class InfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        mainStack.fillSafeArea(topPadding: Spacing.standard)
    }
    
    let bestPriceLabel = UILabel()
    let normalPriceLabel = UILabel()
    
    private lazy var mainStack: CustomStack = {
        let stack = CustomStack(
            axis: .vertical,
            arrangedSubViews: [
                imageBanner,
                gameNameText,
                storesTableView
            ],
            spacing: Spacing.standard
        )
        
        return stack
    }()
    
    var imageBanner: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "gamecontroller.fill")
        img.backgroundColor = .secondarySystemBackground
        img.contentMode = .center
        img.clipsToBounds = true
        img.layer.cornerRadius = 12
        img.translatesAutoresizingMaskIntoConstraints = false
        img.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 60)
        
        NSLayoutConstraint.activate([
            img.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        return img
    }()
    
    var gameNameText: UILabel = {
        let label = UILabel()
        label.textColor = .black

        let baseFont = UIFont.preferredFont(forTextStyle: .title2)
        if let boldDescriptor = baseFont.fontDescriptor.withSymbolicTraits(.traitBold) {
            label.font = UIFont(descriptor: boldDescriptor, size: 0)
        }
        
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var storesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.rowHeight = 60
        table.isScrollEnabled = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.showsVerticalScrollIndicator = false
        table.register(StoreCell.self, forCellReuseIdentifier: StoreCell.reuseIdentifier)
        table.register(PriceCell.self, forCellReuseIdentifier: PriceCell.reuseIdentifier)
        return table
    }()
    
    lazy var priceInfoStack: CustomStack = {
        let stack = CustomStack(
            axis: .vertical,
            arrangedSubViews: [bestPriceRow, normalPriceRow],
            spacing: 12
        )
        return stack
    }()
    
    private lazy var bestPriceRow: CustomStack = {
        makePriceRow(labelText: "Menor preço já registrado", valueLabel: bestPriceLabel)
    }()
    
    private lazy var normalPriceRow: CustomStack = {
        makePriceRow(labelText: "Preço normal", valueLabel: normalPriceLabel)
    }()
    
    private func makePriceRow(labelText: String, valueLabel: UILabel) -> CustomStack {
        let label = UILabel()
        label.text = labelText
        label.font = UIFont.preferredFont(forTextStyle: .body)
        
        valueLabel.font = .preferredFont(forTextStyle: .body)
        valueLabel.textColor = .secondaryLabel
        
        let row = CustomStack(axis: .horizontal, arrangedSubViews: [label, valueLabel])
        row.distribution = .equalSpacing
        return row
    }
}

#Preview {
    InfoView()
}
