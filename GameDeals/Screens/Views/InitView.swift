import UIKit

class InitView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(activityIndicator)
        addSubview(mainStackView)
    }
    
    private func setupConstraints() {
        mainStackView.fillSafeArea()
        
        NSLayoutConstraint.activate([
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private lazy var mainStackView: CustomStack = {
        let customStack = CustomStack(
            axis: .vertical,
            arrangedSubViews: [
                subtitleLabel,
                segmentedControl,
                tableView
            ]
        )
        return customStack
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Melhores preços do momento"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemGray2
        label.textAlignment = .left
        return label
    }()
    
    let segmentedControl: UISegmentedControl = {
        let items = ["Desconto", "Preço", "Nota"]
        let control = UISegmentedControl(items: items)
        
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = .systemBlue
        
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorStyle = .singleLine
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 80
        
        return table
    }()
}

#Preview {
    InitView()
}
