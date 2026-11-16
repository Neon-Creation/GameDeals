import UIKit

class InitViewController: UIViewController {
    private let initView = InitView()
    
    private var deals: [GameDeal] = []
    
    override func loadView() {
        view = initView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyles()
        configTable()
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
    }
    
    func fetchDealsFromApi() {
        Task {
            do {
                let APIdeals: [GameDeal] = try await CheapSharksService.shared.fetchDeals()
                deals = APIdeals
                self.initView.tableView.reloadData()
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}

extension InitViewController: UITableViewDataSource {
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
        
        return cell
    }
}

#Preview {
    InitViewController()
}
