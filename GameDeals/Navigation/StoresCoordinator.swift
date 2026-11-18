import UIKit

final class StoresCoordinator: Coordinator {
    var childrenCoordinator: [any Coordinator] = []
    
    weak var parentCoordinator: Coordinator?

    var rootViewController: UIViewController { navigationController }
    
    let navigationController: UINavigationController = UINavigationController()
    
    func start() {
        navigationController.tabBarItem = UITabBarItem(
            title: "Lojas",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        navigationController.setViewControllers([StoreViewController()], animated: false)
    }
    
    func finish() {
        parentCoordinator?.removeChild(self)
    }
    
    
}
