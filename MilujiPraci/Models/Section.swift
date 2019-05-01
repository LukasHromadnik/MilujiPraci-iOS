//
//  Section.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

enum Section {
    case basic
    case extra
    case milos

    var title: String {
        switch self {
        case .basic: return "Basic"
        case .extra: return "Extra"
        case .milos: return "Miloš Zeman"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .basic: return .mainGreen
        case .extra: return .mainGreen
        case .milos: return .mainPink
        }
    }
}
