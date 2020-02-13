//
//  TrackListViewModeling.swift
//  MilujuPraci
//
//  Created by Lukáš Hromadník on 06/03/2019.
//  Copyright © 2019 Lukáš Hromadník. All rights reserved.
//

import Foundation
import AVKit

protocol TrackListViewModeling: NSObjectProtocol {
    var sections: [Section] { get }
    var trackTitle: String? { get }
    var isTrackSelected: Bool { get }
    var onFinish: (() -> Void)? { get set }

    func play()
    func pause()
    func stop()
    func selectTrack(at indexPath: IndexPath)
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

final class TrackListViewModel: NSObject, TrackListViewModeling {
    let sections = DataSource.sections

    var trackTitle: String? {
        selectedTrack?.title
    }

    var isTrackSelected: Bool {
        selectedTrack != nil
    }

    var onFinish: (() -> Void)?

    private var selectedTrack: Track?
    private var player: AVAudioPlayer?

    // MARK: - Public API

    func pause() {
        player?.pause()
    }

    func play() {
        if (player?.currentTime ?? 0) == 0 {
            player?.stop()

            guard let url = selectedTrack?.fileURL else { return }

            player = try? AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(.playback)
            try? audioSession.setActive(true)
        }

        player?.play()
    }

    func stop() {
        pause()
        player?.currentTime = 0
    }

    func selectTrack(at indexPath: IndexPath) {
        selectedTrack = item(for: indexPath)
    }
}

extension TrackListViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        onFinish?()
    }
}
