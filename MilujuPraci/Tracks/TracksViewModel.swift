//
//  TracksViewModel.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation

protocol TracksViewModeling: class {
    var viewModels: [TrackListViewModeling] { get }
    var selectedIndex: Int { get set }
}

extension TracksViewModeling {
    
    var title: String? {
        return viewModels[selectedIndex].title
    }
    
    func numberOfLists() -> Int {
        return viewModels.count
    }
    
}

final class TracksViewModel: TracksViewModeling {
    let viewModels: [TrackListViewModeling] = [BasicTrackListViewModel(), MilosTrackListViewModel()]

    var selectedIndex = 0
}
