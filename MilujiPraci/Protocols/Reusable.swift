//
//  Reusable.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

protocol Reusable { }

extension Reusable {

    static var reuseIdentifier: String {
        // swiftlint:disable:next force_cast
        return NSStringFromClass(self as! AnyObject.Type)
    }

}

extension UICollectionReusableView: Reusable { }

extension UICollectionView {

    func dequeueCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }

    func dequeueHeader<Header>(for indexPath: IndexPath) -> Header where Header: UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        register(Header.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: Header.reuseIdentifier)
        // swiftlint:disable:next force_cast
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseIdentifier, for: indexPath) as! Header
    }

}
