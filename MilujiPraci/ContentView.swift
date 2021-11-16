//
//  ContentView.swift
//  MilujiPraci
//
//  Created by Lukáš Hromadník on 16.11.2021.
//

import SwiftUI

struct ContentView: View {
    private enum Constants {
        static let interitemSpacing: CGFloat = 10
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(dataSource) { section in
                        Text(section.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(
                                Color.app.border
                                    .overlay(
                                        Color(.secondarySystemBackground)
                                            .padding(.vertical, 1)
                                    )
                            )

                        LazyVGrid(
                            columns: [
                                GridItem(spacing: Constants.interitemSpacing),
                                GridItem(spacing: Constants.interitemSpacing),
                                GridItem(spacing: Constants.interitemSpacing)
                            ],
                            spacing: Constants.interitemSpacing
                        ) {
                            ForEach(section.tracks) { track in
                                TrackView(track: track, sectionColor: section.color)
                            }
                        }
                        .padding(Constants.interitemSpacing)
                    }
                }
            }
            .navigationBarTitle("Miluju práci")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
