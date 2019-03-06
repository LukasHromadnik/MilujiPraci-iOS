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
        return NSStringFromClass(self as! AnyObject.Type)
    }
    
}

extension UICollectionReusableView: Reusable { } 
