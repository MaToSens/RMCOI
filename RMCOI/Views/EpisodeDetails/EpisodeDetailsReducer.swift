//
//  EpisodeDetailsReducer.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct EpisodeDetailsReducer {
    
    @ObservableState
    struct State: Equatable, Identifiable{
        var id: String
        var contentState: Loadable
        
        init(episodeId: String, contentState: Loadable = .idle) {
            self.id = episodeId
            self.contentState = contentState
        }
    }
    
    enum Action: Equatable {
        case onApper
        case contentLoaded(Episode)
        case contentLoadFailed(String)
        case dismissButtonTapped
    }
    
    enum Loadable: Equatable {
        case idle
        case loading
        case loaded(Episode)
        case failed(String)
    }
    
    @Dependency(\.episodeClient) private var episodeClient
    @Dependency(\.dismiss) private var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onApper:
                let episodeId = state.id
                state.contentState = .loading
                
                return .run { send in
                    let episode = try await episodeClient.fetchEpisode(episodeId)
                    await send(.contentLoaded(episode))
                } catch: { error, send in
                    await send(.contentLoadFailed(error.localizedDescription))
                }
                
            case let .contentLoaded(episode):
                state.contentState = .loaded(episode)
                return .none
                
            case let .contentLoadFailed(error):
                state.contentState = .failed(error)
                return .none
                
            case .dismissButtonTapped:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
