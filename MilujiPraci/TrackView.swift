//
//  TrackView.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 16.11.2021.
//

import SwiftUI

struct TrackView: View {
    @StateObject private var viewModel: TrackViewModel
    private let sectionColor: Color

    init(track: Track, sectionColor: Color) {
        _viewModel = StateObject(wrappedValue: TrackViewModel(track: track))
        self.sectionColor = sectionColor
    }

    var body: some View {
        Button {
            viewModel.play()
        } label: {
            Rectangle()
                .fill(sectionColor)
                .aspectRatio(1, contentMode: .fill)
                .overlay(
                    GeometryReader { proxy in
                        Rectangle()
                            .fill(Color.black.opacity(0.2))
                            .frame(width: proxy.size.width * viewModel.progress)
                    }
                )
                .overlay(
                    Text(viewModel.track.title)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(6)
                )
        }
    }
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView(track: Track(title: "Track", filename: ""), sectionColor: .red)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
