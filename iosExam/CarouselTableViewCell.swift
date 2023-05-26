import Foundation
import UIKit

/// Ячейка с каруселью из цифр.
class CarouselTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CarouselTableViewCell"
    
    // MARK: Private properties.
    
    private var viewModel: ViewModel?
    
    // MARK: Subviews.
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NumberCollectionViewCell.self, forCellWithReuseIdentifier: NumberCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: Init.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods.
    
    func setup(with viewModel: ViewModel) {
        // Зануляем оффсет чтобы не кофликтовать с другими ячейками
        collectionView.setContentOffset(.init(
            x: 2 * collectionView.contentSize.width / 5,
            y: 0
        ), animated: false)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = viewModel.horizontalSpacing
        self.viewModel = viewModel
        collectionView.reloadData()
    }
}

// MARK: ViewModel.

extension CarouselTableViewCell {
    struct ViewModel {
        let numberOfColumns: Int
        let multiplier: Int
        let horizontalSpacing: CGFloat
        let rowHeight: CGFloat
    }
}

// MARK: UICollectionViewDataSource

extension CarouselTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (viewModel?.numberOfColumns ?? 0) * 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: NumberCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? NumberCollectionViewCell
        
        cell?.setup(with: (viewModel?.multiplier ?? 0) * (indexPath.row % (viewModel?.numberOfColumns ?? 1) + 1))
        return cell ?? UICollectionViewCell()
    }
}

extension CarouselTableViewCell: UICollectionViewDelegate {
    
    /// Обеспечивает бесконечный скролл UICollectionView по карусели.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 3.5 * scrollView.contentSize.width / 5 {
            scrollView.contentOffset.x -= scrollView.contentSize.width / 5
        } else if scrollView.contentOffset.x < 1.5 * scrollView.contentSize.width / 5 {
            scrollView.contentOffset.x += scrollView.contentSize.width / 5
        }
    }
}
