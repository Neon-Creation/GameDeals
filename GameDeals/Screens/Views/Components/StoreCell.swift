import UIKit

class StoreCell: UITableViewCell {
    static let reuseIdentifier = "StoreCell"
    
    private let storeNameLabel = UILabel()
    private let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        storeNameLabel.font = .preferredFont(forTextStyle: .body)
        priceLabel.font = .preferredFont(forTextStyle: .body)
        priceLabel.textColor = .secondaryLabel
        
        let stack = CustomStack(axis: .horizontal, arrangedSubViews: [storeNameLabel, priceLabel])
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        self.selectionStyle = .none
    }
    
    func configure(store: StoreDeal) {
        storeNameLabel.text = store.storeName
        priceLabel.text = "R$ \(store.salePrice)"
    }
}
