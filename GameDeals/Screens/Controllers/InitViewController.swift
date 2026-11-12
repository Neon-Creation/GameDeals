import UIKit

class InitViewController: UIViewController {
    private let initView = InitView()
    
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
}

#Preview {
    InitViewController()
}
