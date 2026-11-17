import UIKit

extension UIView {
    func padding(padding: UIEdgeInsets) {
        guard let superview = superview else { return }
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right),
        ])
    }
    
    func padding(_ allSides: CGFloat) {
        let edgeInsets = UIEdgeInsets(top: allSides, left: allSides, bottom: allSides, right: allSides)
        padding(padding: edgeInsets)
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
