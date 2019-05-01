//
//  Track.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 27/02/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

struct Track {
    let title: String
    let filename: String
}

extension Track {

    var fileURL: URL? {
        return Bundle.main.url(forResource: filename, withExtension: nil)
    }

}
