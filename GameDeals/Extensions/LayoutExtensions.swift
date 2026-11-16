import UIKit

extension UIView {
    func withPadding(_ padding: UIEdgeInsets) -> UIView {
        let container = UIView()
            
        container.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: padding.top),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding.bottom),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding.left),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding.right)
        ])
        
        return container
    }
    
    func withPadding(_ allSides: CGFloat) -> UIView {
        let insets = UIEdgeInsets(top: allSides, left: allSides, bottom: allSides, right: allSides)
        return withPadding(insets)
    }
}

extension UIView {
    func fillSuperView() {
        guard let superview = self.superview else {
            fatalError("Call addSubView before calling this function")
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
    
    func fillSafeArea(horizontalPadding: CGFloat = Spacing.standard, topPadding: CGFloat = 0) {
        guard let superview = self.superview else {
            fatalError("Call addSubView before calling this function")
        }
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: topPadding),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: horizontalPadding),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -horizontalPadding),
        ])
    }
}
