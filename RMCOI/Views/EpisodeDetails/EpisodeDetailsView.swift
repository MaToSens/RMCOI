//
//  EpisodeDetailsView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import SwiftUI

struct EpisodeDetailsView: View {
    let store: StoreOf<EpisodeDetailsReducer>
    
    var body: some View {
        WithPerceptionTracking {
            switch store.contentState {
            case .idle:
                Color.clear
            case .loading:
                ProgressView()
                    .scaleEffect(1.2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case let .loaded(episode):
                loadedContentView(episode: episode)
            case let .failed(errorDescription):
                FeedbackView.errorView(errorDescription) {
                    store.send(.dismissButtonTapped)
                }
            }
        }
        .onAppear { store.send(.onApper) }
    }
    
    private func loadedContentView(episode: Episode) -> some View {
        VStack {
            DetailRow(title: "Name:", value: episode.name)
            DetailRow(title: "Air Date:", value: episode.airDate)
            DetailRow(title: "Episode:", value: episode.episode)
            DetailRow(title: "Characters:", value: "\(episode.characters.count)")
        }
        .padding()
        .background(.secondary)
        .navigationTitle(episode.name)
    }
}

