//
//  UICollectionViewExtension.swift
//  Portto
//
//  Created by Vincent on 2022/5/6.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.className)
    }

    func dequeueReusableCell<Cell: UICollectionViewCell>(with type: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! Cell
    }
}
