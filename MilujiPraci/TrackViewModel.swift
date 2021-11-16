//
//  TrackViewModel.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 16.11.2021.
//

import SwiftUI

final class TrackViewModel: ObservableObject {
    @Published var progress = 0.0

    let track: Track

    private let playerManager = PlayerManager.shared

    // MARK: - Initialization

    init(track: Track) {
        self.track = track
    }

    // MARK: - Public API

    func play() {
        playerManager.play(track: track) { [weak self] in self?.progress = $0 }
    }
}
