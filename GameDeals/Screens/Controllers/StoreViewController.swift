import UIKit

class StoreViewController: UIViewController {
    override func loadView() {
        view = ShoppingListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyles()
    }
    
    private func navigationStyles() {
        self.title = "Lojas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
