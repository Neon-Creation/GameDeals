import UIKit

final class AppCoordinator: Coordinator {
    var rootViewController: UIViewController { tabBarController }
    
    var childrenCoordinator: [Coordinator] = []
    var parentCoordinator: Coordinator?

    private let window: UIWindow
    private let tabBarController = MainTabBarController()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let deals = DealsCoordinator()
        let search = SearchCoordinator()
        let stores = StoresCoordinator()
        
        let coordinators: [Coordinator] = [deals, search, stores]
        
        addChild(deals)
        addChild(search)
        addChild(stores)
        
        coordinators.forEach {$0.start()}
        
        tabBarController.setTabs([
            deals.rootViewController,
            search.rootViewController,
            stores.rootViewController
        ])
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
    }
    
    func finish() {
        let children = childrenCoordinator
        children.forEach { $0.finish() }
        childrenCoordinator.removeAll()
        window.rootViewController = nil
    }
    
    
}
