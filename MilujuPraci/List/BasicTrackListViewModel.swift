//
//  BasicTrackListViewModel.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation

final class BasicTrackListViewModel: TrackListViewModeling {
    let tracks = Track.allBasic
    let title = "Miluju práci"
}
