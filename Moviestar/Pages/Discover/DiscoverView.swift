//
//  DiscoverView.swift
//  Moviestar
//
//  Created by Frederik Christensen on 19/01/2021.
//

import UIKit

protocol DiscoverViewDelegate: AnyObject {
    func didTapMovie(indexPath: IndexPath)
}

final class DiscoverView: UIView {
    
    // MARK: - Properties
    let collectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)
        itemLayout.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.7))
        let groupLayout = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: itemLayout,
            count: 2)
        let section = NSCollectionLayoutSection(group: groupLayout)
        section.contentInsets = .init(top: 8, leading: 8, bottom: 0, trailing: 8)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        let this = UICollectionView(frame: .zero, collectionViewLayout: layout)
        this.translatesAutoresizingMaskIntoConstraints = false
        this.backgroundColor = .clear
        return this
    }()

    weak var delegate: DiscoverViewDelegate?
    
    convenience init() {
        self.init(frame: .zero)
        configureView()
        configureSubviews()
        configureConstraints()
        configureDelegate()
    }
    
    private func configureDelegate() {
        collectionView.delegate = self
    }

    private func configureView() {
        backgroundColor = .clear
    }

    private func configureSubviews() {
        addSubview(collectionView)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
        
        ])
    }
    
}

extension DiscoverView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapMovie(indexPath: indexPath)
    }
}
