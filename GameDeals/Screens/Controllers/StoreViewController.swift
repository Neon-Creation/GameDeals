import UIKit

class StoreViewController: UIViewController {
    let storeView = StoresListView()
    
    override func loadView() {
        view = storeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTable()
        navigationStyles()
    }
    
    private func navigationStyles() {
        self.title = "Lojas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    private func setupTable() {
//        storeView.tableView.register(DealTableViewCell.self, forCellReuseIdentifier: DealTableViewCell.reuseIdentifier)
//        storeView.tableView.dataSource = self
//    }
}
