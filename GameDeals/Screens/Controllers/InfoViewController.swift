import UIKit

class InfoViewCpntroller: UIViewController {
    private let infoView = InfoView()
    
    override func loadView() {
        self.view = infoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
