import UIKit

final class DealsCoordinator: Coordinator {
    var childrenCoordinator: [any Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    var rootViewController: UIViewController { navigationController }
    let navigationController: UINavigationController = UINavigationController()
    
    func start() {
        navigationController.tabBarItem = UITabBarItem(
            title: "Ofertas",
            image: UIImage(systemName: "tag"),
            selectedImage: UIImage(systemName: "tag.fill")
        )
        
        let listVC = InitViewController()

        listVC.onDealSelected = { [weak self] deal, image in
            let detailVC = InfoViewController(deal: deal, image: image)
            detailVC.hidesBottomBarWhenPushed = true
            self?.navigationController.pushViewController(detailVC, animated: true)
        }
        
        navigationController.setViewControllers([listVC], animated: false)
    }
    
    func finish() {
        childrenCoordinator.forEach {$0.finish()}
        childrenCoordinator.removeAll()
        parentCoordinator?.removeChild(self)
    }
}
