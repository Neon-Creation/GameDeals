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
    }
    
    private func navigationStyles() {
        self.title = "Ofertas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func loadSampleData() {
        // Dados de teste mockados
//        deals = [
//            GameDeal(dealID: "1", title: "Cyberpunk 2077", salePrice: "99.90", normalPrice: "199.90", savings: "50", thumb: ""),
//            GameDeal(dealID: "2", title: "Hades II", salePrice: "66.74", normalPrice: "88.99", savings: "25", thumb: ""),
//            GameDeal(dealID: "3", title: "Hollow Knight", salePrice: "23.49", normalPrice: "46.99", savings: "50", thumb: "")
//        ]
        initView.tableView.reloadData()
    }
}

#Preview {
    InitViewController()
}
