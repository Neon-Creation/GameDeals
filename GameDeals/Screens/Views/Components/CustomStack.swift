import UIKit

class CustomStack: UIStackView {
    
    init(
        axis: NSLayoutConstraint.Axis,
        arrangedSubViews: [UIView],
        spacing: CGFloat = 16,
        alignment: UIStackView.Alignment = .fill
    ) {
        super.init(frame: .zero)
        
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = .fill
        self.translatesAutoresizingMaskIntoConstraints = false
        
        arrangedSubViews.forEach { addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("A classe HStack precisa ser inicializada")
    }
    
}
