//
//  TracksViewModel.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation

protocol TracksViewModeling {
    var viewModels: [TrackListViewModeling] { get }
}

extension TracksViewModeling {
    
    func numberOfLists() -> Int {
        return viewModels.count
    }
    
}

final class TracksViewModel: TracksViewModeling {
    let viewModels: [TrackListViewModeling] = [BasicTrackListViewModel(), MilosTrackListViewModel()]
}
