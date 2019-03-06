//
//  TrackListViewModeling.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation
import AVKit

protocol TrackListViewModeling {
    var sections: [Section] { get }

    func playTrack(at indexPath: IndexPath)
}

extension TrackListViewModeling {

    var numberOfSections: Int {
        return sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        return sections[section].numberOfItems
    }

    func item(for indexPath: IndexPath) -> Track {
        return sections[indexPath.section].item(for: indexPath)
    }

}

final class TrackListViewModel: TrackListViewModeling {

    let sections = [
        Section(title: "Basic", tracks: Track.allBasic),
        Section(title: "Extra", tracks: Track.allExtra),
        Section(title: "Milošek", tracks: Track.allMilos)
    ]

    private var player: AVAudioPlayer?

    // MARK: - Public API

    func playTrack(at indexPath: IndexPath) {
        player?.stop()

        guard let url = item(for: indexPath).fileURL else { return }

        player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        player?.play()
    }

}
