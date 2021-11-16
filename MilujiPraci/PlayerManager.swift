//
//  PlayerManager.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 16.11.2021.
//

import Foundation
import AVFoundation

final class PlayerManager: NSObject, ObservableObject {
    private var player: AVAudioPlayer?
    private var timer: Timer?
    private var onProgressChanged: ((Double) -> Void)?

    static let shared = PlayerManager()

    override private init() { super.init() }

    func play(track: Track, onProgressChanged: @escaping (Double) -> Void) {
        if player?.isPlaying == true {
            stop()
        }

        self.onProgressChanged = onProgressChanged

        guard let url = track.fileURL else { assertionFailure(); return }

        player = try? AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        player?.prepareToPlay()
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback)
        try? audioSession.setActive(true)

        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            let currentTime = self?.player?.currentTime ?? 0
            let totalTime = self?.player?.duration ?? 0
            onProgressChanged(currentTime / totalTime)
        }
        self.timer = timer

        // Timer was disabled during scrolling, this line fixes it
        RunLoop.main.add(timer, forMode: .common)

        player?.play()
    }

    fileprivate func stop() {
        player?.stop()
        timer?.invalidate()
        onProgressChanged?(0)
    }
}

extension PlayerManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        stop()
    }
}
