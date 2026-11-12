import UIKit

class InitView: UIView {
    let tableView = UITableView()
    let sortControl = UISegmentedControl(items: ["Desconto", "Preço", "Nome"])
    let refreshControl = UIRefreshControl()
    let retryButton = UIButton(type: .system)

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let stateContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mainStackView: CustomStack = {
        let customStack = CustomStack(
            axis: .vertical,
            arrangedSubViews: [
                subtitleLabel,
                sortControl,
                tableView
            ],
            spacing: Spacing.standard
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
    
    private func setupView() {
        addSubview(mainStackView)
        sortControl.selectedSegmentIndex = 0
        tableView.rowHeight = 88
        tableView.register(DealTableViewCell.self, forCellReuseIdentifier: DealTableViewCell.reuseIdentifier)

        retryButton.setTitle("Tentar novamente", for: .normal)
        retryButton.isHidden = true

        let stateStack = UIStackView(arrangedSubviews: [activityIndicator, messageLabel, retryButton])
        stateStack.axis = .vertical
        stateStack.alignment = .center
        stateStack.spacing = Spacing.small
        stateStack.translatesAutoresizingMaskIntoConstraints = false
        stateContainer.addSubview(stateStack)

        NSLayoutConstraint.activate([
            stateStack.centerXAnchor.constraint(equalTo: stateContainer.centerXAnchor),
            stateStack.centerYAnchor.constraint(equalTo: stateContainer.centerYAnchor),
            stateStack.leadingAnchor.constraint(greaterThanOrEqualTo: stateContainer.leadingAnchor, constant: Spacing.large),
            stateStack.trailingAnchor.constraint(lessThanOrEqualTo: stateContainer.trailingAnchor, constant: -Spacing.large)
        ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.standard),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.standard),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.standard),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func showLoading() {
        messageLabel.text = "Carregando promoções..."
        retryButton.isHidden = true
        activityIndicator.startAnimating()
        tableView.backgroundView = stateContainer
    }

    func showError(_ message: String) {
        messageLabel.text = message
        retryButton.isHidden = false
        activityIndicator.stopAnimating()
        tableView.backgroundView = stateContainer
    }

    func showEmptyState() {
        messageLabel.text = "Nenhuma promoção encontrada no momento."
        retryButton.isHidden = false
        activityIndicator.stopAnimating()
        tableView.backgroundView = stateContainer
    }

    func showDeals() {
        activityIndicator.stopAnimating()
        tableView.backgroundView = nil
    }
}

#Preview {
    InitView()
}
