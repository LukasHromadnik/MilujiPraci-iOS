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
    var trackTitle: String? { get }
    var isTrackSelected: Bool { get }
    var onFinish: (() -> Void)? { get set }
    var onDurationChange: ((Double) -> Void)? { get set }

    func play()
    func pause()
    func stop()
    func selectTrack(at indexPath: IndexPath)
}

extension TrackListViewModeling {
    var numberOfSections: Int {
        dataSource.count
    }

    func numberOfItems(in section: Int) -> Int {
        dataSource[section].tracks.count
    }

    func item(for indexPath: IndexPath) -> Track {
        dataSource[indexPath.section].tracks[indexPath.row]
    }

    func backgroundColor(for indexPath: IndexPath) -> UIColor {
        dataSource[indexPath.section].color
    }

    func sectionTitle(at indexPath: IndexPath) -> String {
        dataSource[indexPath.section].name
    }
}

final class TrackListViewModel: NSObject, TrackListViewModeling {
    var trackTitle: String? { selectedTrack?.title }
    var isTrackSelected: Bool { selectedTrack != nil }

    var onFinish: (() -> Void)?
    var onDurationChange: ((Double) -> Void)?

    private var selectedTrack: Track?
    private var player: AVAudioPlayer?
    private var timer: Timer?

    // MARK: - Public API

    func pause() {
        player?.pause()
        timer?.invalidate()
    }

    func play() {
        if (player?.currentTime ?? 0) == 0 {
            player?.stop()
            timer?.invalidate()

            guard let url = selectedTrack?.fileURL else { return }

            player = try? AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            try? audioSession.setCategory(.playback)
            try? audioSession.setActive(true)
        }

        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            let currentTime = self?.player?.currentTime ?? 0
            let totalTime = self?.player?.duration ?? 0
            self?.onDurationChange?(currentTime / totalTime)
        }
        self.timer = timer

        // Timer was disabled during scrolling, this line fixes it
        RunLoop.main.add(timer, forMode: .common)

        player?.play()
    }

    func stop() {
        pause()
        player?.currentTime = 0
        onDurationChange?(0)
    }

    func selectTrack(at indexPath: IndexPath) {
        selectedTrack = item(for: indexPath)
        stop()
    }
}

extension TrackListViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        stop()
        onFinish?()
    }
}
