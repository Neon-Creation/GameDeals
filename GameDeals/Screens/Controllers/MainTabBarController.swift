import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        setupTabBarStyle()
    }
    
    private func setupTabs() {
        let initVC = InitViewController()
        let nav1 = UINavigationController(rootViewController: initVC)
        
        nav1.tabBarItem = UITabBarItem(
            title: "Ofertas",
            image: UIImage(systemName: "tag"),
            selectedImage: UIImage(systemName: "tag.fill")
        )
        
        
        let searchVC = SearchViewController()
        let nav2 = UINavigationController(rootViewController: searchVC)
        
        nav2.tabBarItem = UITabBarItem(
            title: "Buscar",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        let shoppingListVC = ShoppingListViewController()
        let nav3 = UINavigationController(rootViewController: shoppingListVC)
        
        nav3.tabBarItem = UITabBarItem(
            title: "Lojas",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        self.viewControllers = [nav1, nav2, nav3]
    }
    
    private func setupTabBarStyle() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .systemBackground
    }
    
}
