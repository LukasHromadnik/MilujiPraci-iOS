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
        sections.count
    }

    func numberOfItems(in section: Int) -> Int {
        DataSource.tracks(for: sections[section]).count
    }

    func item(for indexPath: IndexPath) -> Track {
        DataSource.tracks(for: sections[indexPath.section])[indexPath.row]
    }
}

final class TrackListViewModel: TrackListViewModeling {
    let sections = DataSource.sections

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
