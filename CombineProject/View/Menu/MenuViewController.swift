//
//  MenuViewController.swift
//  CombineProject
//
//  Created by Davidyoon on 4/19/24.
//

import UIKit
import Combine
import SnapKit

final class MenuViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(MenuCollectionViewCell.self)
        
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, String> = {
        .init(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(MenuCollectionViewCell.self, for: indexPath)
            
            return cell
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension MenuViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
    }
    
    
}

#Preview {
    MenuViewController()
}
