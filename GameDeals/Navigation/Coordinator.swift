import UIKit

protocol Coordinator: AnyObject {
    var childrenCoordinator: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    var rootViewController: UIViewController { get }
    func start()
    func finish()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        coordinator.parentCoordinator = self
        childrenCoordinator.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator) {
        childrenCoordinator.removeAll { $0 === coordinator }
    }
}
