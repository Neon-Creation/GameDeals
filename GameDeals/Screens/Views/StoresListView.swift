import UIKit

class StoresListView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(mainStack)
    }
    
    func setupConstraints() {
        mainStack.fillSafeArea()
    }
    
    private lazy var mainStack: CustomStack = {
        let stack = CustomStack(axis: .vertical, arrangedSubViews: [labelText, tableView])
        return stack
    }()
    
    private let labelText: UILabel = {
        let label = UILabel()
        label.text = "Monitorados pelo IsThereAnyDeal"
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()
}
