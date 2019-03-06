//
//  TracksViewModel.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation
import AVKit

protocol TracksViewModeling: class {
    var viewModels: [TrackListViewModeling] { get }
    var selectedIndex: Int { get set }
    
    func play(track: Track)
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
    
    private var player: AVAudioPlayer?
    
    func play(track: Track) {
        guard let url = track.fileURL else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }
}
