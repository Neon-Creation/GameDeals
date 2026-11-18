import UIKit

final class SearchCoordinator: Coordinator {
    var childrenCoordinator: [any Coordinator] = []
    weak var parentCoordinator: Coordinator?
    var rootViewController: UIViewController { navigationController }
    
    let navigationController = UINavigationController()
    
    func start() {
        navigationController.tabBarItem = UITabBarItem(
            title: "Buscar",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        navigationController.setViewControllers([SearchViewController()], animated: false)
    }
    
    func finish() {
        parentCoordinator?.removeChild(self)
    }
}
