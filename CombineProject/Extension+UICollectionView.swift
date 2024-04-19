//
//  Extension+UICollectionView.swift
//  CombineProject
//
//  Created by Davidyoon on 4/19/24.
//

import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell> (_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func registerHeaderView<T: UICollectionReusableView> (_: T.Type) {
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
    }
    
    func registerFooterView<T: UICollectionReusableView> (_: T.Type) {
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell> (_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not find \(T.identifier)")
        }
        
        return cell
    }
    
    func dequeueReusableHeaderView<T: UICollectionReusableView> (_: T.Type, for indexPath: IndexPath) -> T {
        guard let headerView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewHeaderFooterView for \(T.identifier), make sure the view is registered with table view")
        }
        
        return headerView
    }
    
    func dequeueReusableFooterView<T: UICollectionReusableView> (_: T.Type, for indexPath: IndexPath) -> T {
        guard let headerView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewHeaderFooterView for \(T.identifier), make sure the view is registered with table view")
        }
        
        return headerView
    }
    
}

protocol IDPresenter {
    
    static var identifier: String { get }
    
}


extension NSObject: IDPresenter {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
