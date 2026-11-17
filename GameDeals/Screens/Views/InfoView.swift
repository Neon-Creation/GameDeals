import UIKit

class InfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(testTest)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            testTest.centerXAnchor.constraint(equalTo: centerXAnchor),
            testTest.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private let testTest: UILabel = {
        let label = UILabel()
        label.text = "Info View"
        return label
    }()
}
