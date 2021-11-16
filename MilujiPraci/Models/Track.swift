//
//  Track.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 27/02/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import UIKit

struct Track {
    let title: String
    let filename: String
}

extension Track: Identifiable {
    var id: String { filename }
}

extension Track {
    var fileURL: URL? {
        Bundle.main.url(forResource: filename, withExtension: nil)
    }
}
