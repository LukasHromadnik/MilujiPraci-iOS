//
//  Section.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation

struct Section {
    let title: String
    let tracks: [Track]
}

extension Section {
    
    var numberOfItems: Int {
        return tracks.count
    }
    
    func item(for indexPath: IndexPath) -> Track {
        return tracks[indexPath.item]
    }
    
}
