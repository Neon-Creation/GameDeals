import UIKit

class InitViewController: UIViewController {
    private let initView = InitView()
    private let dealsService = SteamDealsService()
    private var deals: [SteamDeal] = []
    private var loadTask: Task<Void, Never>?
    
    override func loadView() {
        view = initView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyles()
        initView.tableView.dataSource = self
        initView.tableView.delegate = self
        initView.sortControl.addTarget(self, action: #selector(sortDeals), for: .valueChanged)
        initView.refreshControl.addTarget(self, action: #selector(refreshDeals), for: .valueChanged)
        initView.tableView.refreshControl = initView.refreshControl
        initView.retryButton.addTarget(self, action: #selector(refreshDeals), for: .touchUpInside)
        loadDeals()
    }
    
    private func navigationStyles() {
        self.title = "Ofertas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc private func refreshDeals() {
        loadDeals()
    }

    @objc private func sortDeals() {
        switch initView.sortControl.selectedSegmentIndex {
        case 1:
            deals.sort { ($0.finalPrice ?? Int.max) < ($1.finalPrice ?? Int.max) }
        case 2:
            deals.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        default:
            deals.sort { $0.discountPercent > $1.discountPercent }
        }

        initView.tableView.reloadData()
    }

    private func loadDeals() {
        loadTask?.cancel()
        if deals.isEmpty {
            initView.showLoading()
        }

        loadTask = Task { [weak self] in
            guard let self else { return }

            do {
                deals = try await dealsService.fetchDeals()
                sortDeals()
                initView.refreshControl.endRefreshing()

                if deals.isEmpty {
                    initView.showEmptyState()
                } else {
                    initView.showDeals()
                }
            } catch is CancellationError {
                return
            } catch {
                initView.refreshControl.endRefreshing()
                if deals.isEmpty {
                    initView.showError("Não foi possível carregar as promoções.\n\(error.localizedDescription)")
                } else {
                    let alert = UIAlertController(
                        title: "Falha ao atualizar",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true)
                }
            }
        }
    }
}

extension InitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DealTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? DealTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: deals[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIApplication.shared.open(deals[indexPath.row].storeURL)
    }
}

#Preview {
    InitViewController()
}
