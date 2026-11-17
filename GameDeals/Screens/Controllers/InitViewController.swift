import UIKit

class InitViewController: UIViewController {
    private let initView = InitView()
    private var deals: [GameDeal] = []

    // API SERVICE
    private let service: DealsServiceProtocol
    private var currentSort: SortOption = .discount
    private var currentTask: Task<Void, Never>?
    
    private let refreshControl = UIRefreshControl()
    
    init(
        service: DealsServiceProtocol = ITADServiceAPI.shared
    ) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = initView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyles()
        configTable()
        setupActions()
        fetchDealsFromApi()
    }
    
    private func navigationStyles() {
        self.title = "Ofertas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configTable() {
        self.initView.tableView.dataSource = self
        self.initView.tableView.register(
            DealTableViewCell.self,
            forCellReuseIdentifier: DealTableViewCell.reuseIdentifier
        )
        
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        initView.tableView.refreshControl = refreshControl
    }
    
    private func setupActions() {
        initView.segmentedControl.addTarget(self, action: #selector(segmentedChanged(_: )), for: .valueChanged)
    }
    
    @objc private func segmentedChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentSort = .discount
        case 1:
            currentSort = .price
        case 2:
            currentSort = .rating
        default:
            currentSort = .discount
        }
        
        print(currentSort)
        
        fetchDealsFromApi()
    }
    
    @objc private func handleRefresh() {
        fetchDealsFromApi(isPullToRefresh: true)
    }
    
    private func showErrorAlert(error: Error) {
        let alert = UIAlertController(
                        title: "Ops, ocorreu um erro",
                        message: error.localizedDescription,
                        preferredStyle: .alert
                    )
        
        alert.addAction(UIAlertAction(title: "Tentar novamente", style: .default) { [weak self] _ in
            self?.fetchDealsFromApi()
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                
        present(alert, animated: true)
    }
    
    func fetchDealsFromApi(isPullToRefresh: Bool = false) {
        currentTask?.cancel()
        
        if !isPullToRefresh {
            initView.activityIndicator.startAnimating()
        }
        
        currentTask = Task { [weak self] in
            guard let self = self else { return }
            
            defer {
                self.initView.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
            
            do {
                let fetchedDeals = try await self.service.fetchDeals(sortBy: self.currentSort)
                
                guard !Task.isCancelled else { return }
                
                self.deals = fetchedDeals
                self.initView.tableView.reloadData()
            } catch {
                guard !Task.isCancelled else { return }
                self.showErrorAlert(error: error)
            }
        }
    }
}

extension InitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DealTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? DealTableViewCell else {
            return UITableViewCell()
        }
        
        let deal = deals[indexPath.row]
        
        cell.configure(deal: deal)
        
        Task {
            let img = await ImageLoader.shared.loadImage(from: deal.thumb)
            cell.setImage(img)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    InitViewController()
}
