//
//  UICollectionView+Extensions.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let cellID = String(describing: cellClass.self)
        self.register(cellClass.self, forCellWithReuseIdentifier: cellID)
    }
    
    func dequeueCell<T>(_ cellClass: T.Type, indexPath path: IndexPath) -> T {
        let cellID = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: cellID, for: path) as! T
    }
}
