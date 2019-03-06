//
//  TrackListViewModeling.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation

protocol TrackListViewModeling {
    var tracks: [Track] { get }
    var title: String { get }
}

extension TrackListViewModeling {
    
    func numberOfItems(in section: Int) -> Int {
        return tracks.count
    }
    
    func item(for indexPath: IndexPath) -> Track {
        return tracks[indexPath.item]
    }
    
}
