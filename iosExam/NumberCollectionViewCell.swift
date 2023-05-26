import Foundation
import UIKit

extension NumberCollectionViewCell {
    /// Константы.
    private enum Constants {
        static let edgeInsets: UIEdgeInsets = .init(top: 12, left: 16, bottom: 12, right: 16)
    }
}

/// Ячейка с цифрой.
class NumberCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "NumberTableViewCell"
    
    // MARK: Subviews.
    
    private let label: Label = .init(with: .classic)
    
    // MARK: Init.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addLabel()
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.cornerRadius = 12
        layer.masksToBounds = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods.
    
    func setup(with number: Int) {
        label.text = "\(number)"
    }
    
    // MARK: Private methods.
    
    /// Добавляет лейбл на карточку.
    private func addLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.edgeInsets.left),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.edgeInsets.right),
            label.topAnchor.constraint(equalTo: topAnchor, constant: Constants.edgeInsets.top),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.edgeInsets.bottom),
        ])
    }
}
