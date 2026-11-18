import UIKit

class InfoViewController: UIViewController {
    private let infoView = InfoView()
    
    var deal: GameDeal
    var image: UIImage
    
    init(deal: GameDeal, image: UIImage) {
        self.deal = deal
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = infoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyles()
        loadGameInfo()
        setupTableView()
    }
    
    private func navigationStyles() {
        self.title = deal.title
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func loadGameInfo() {
        infoView.imageBanner.image = image
        infoView.imageBanner.contentMode = .scaleToFill
        
        infoView.gameNameText.text = deal.title
        infoView.bestPriceLabel.text = "R$ \(deal.salePrice)"
        infoView.normalPriceLabel.text = "R$ \(deal.normalPrice)"
    }
    
    private func setupTableView() {
        infoView.storesTableView.dataSource = self
        
        let calculatedHeight = CGFloat(2 * 60 + 40 + deal.stores.count * 60)
        let finalHeight = max(300, calculatedHeight)
        
        infoView.storesTableView.heightAnchor.constraint(equalToConstant: finalHeight).isActive = true
    }
}

extension InfoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return deal.stores.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceCell.reuseIdentifier, for: indexPath) as? PriceCell else {
                return UITableViewCell()
            }
            
            if indexPath.row == 0 {
                cell.configure(title: "Menor preco já registrado", value: "R$ \(deal.salePrice)")
            } else {
                cell.configure(title: "Preço normal", value: "R$ \(deal.normalPrice)")
            }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StoreCell.reuseIdentifier, for: indexPath) as? StoreCell else {
               return UITableViewCell()
           }
           let store = deal.stores[indexPath.row]
           cell.configure(store: store)
           return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        case 1: return "Ofertas por loja"
        default: return nil
        }
    }
    
}
