import Foundation
import UIKit

/// Лейбл с поддержной дизайн-системы.
class Label: UILabel {
    
    private var appearance: Appearance
    
    init(with appearance: Appearance, text: String? = nil) {
        self.appearance = appearance
        
        super.init(frame: .zero)
        
        self.text = text
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(_ text: String) {
        self.text = text
    }
    
    private func setup() {
        font = .systemFont(ofSize: appearance.fontSize, weight: appearance.fontWeight)
        textColor = appearance.color
    }
    
}

extension Label {
    struct Appearance {
        static let classic: Self = .init(
            color: .black,
            fontWeight: .black,
            fontSize: 64
        )
        
        let color: UIColor
        let fontWeight: UIFont.Weight
        let fontSize: CGFloat
    }
}
