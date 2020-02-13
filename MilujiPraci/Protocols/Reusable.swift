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

    /// Reuse identifier describing the element
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: Reusable { }

extension UICollectionView {

    /// Dequeues collection view cell of given type
    ///
    /// - Parameters:
    ///   - indexPath: `IndexPath` of the cell
    ///   - ofType: Helper parameter when the result type is not inferable
    /// - Returns: Reusable `Cell` of given type
    func dequeueCell<Cell>(for indexPath: IndexPath, ofType: Cell.Type = Cell.self) -> Cell where Cell: UICollectionViewCell {
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
    }

    /// Dequeues collection view header of given type
    ///
    /// - Parameters:
    ///   - indexPath: `IndexPath` of the header
    ///   - ofType: Helper parameter when the result type is not inferable
    /// - Returns: Reusable `Header` of given type
    func dequeueHeader<Header>(for indexPath: IndexPath, ofType: Header.Type = Header.self) -> Header where Header: UICollectionReusableView {
        let kind = UICollectionView.elementKindSectionHeader
        register(Header.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: Header.reuseIdentifier)
        // swiftlint:disable:next force_cast
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseIdentifier, for: indexPath) as! Header
    }
}
