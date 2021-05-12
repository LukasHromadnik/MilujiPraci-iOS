//
//  UIEdgeInsets.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 01/05/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    /// Creates insets with same given `size`
    init(size: CGFloat) {
        self.init(top: size, left: size, bottom: size, right: size)
    }
}
