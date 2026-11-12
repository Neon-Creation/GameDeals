import UIKit

class SearchViewController: UIViewController {
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationStyles()
    }
    
    private func navigationStyles() {
        self.title = "Buscar"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
