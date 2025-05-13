//
//  CharacterDetailsReducer.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CharacterDetailsReducer {
    
    @ObservableState
    struct State: Equatable, Identifiable {
        var id: Int { character.id }
        var character: Character
        var episodeIDs: [String]
        
        @Presents var episodeDetails: EpisodeDetailsReducer.State?
        
        init(
            character: Character,
            episodeIDs: [String] = [],
            episodeDetails: EpisodeDetailsReducer.State? = nil
        ) {
            self.character = character
            self.episodeIDs = character.episode.extractEpisodeIds()
            self.episodeDetails = episodeDetails
        }
    }
    
    enum Action: Equatable {
        case episodeIdSelected(String)
        case episodeDetails(PresentationAction<EpisodeDetailsReducer.Action>)
        case dismissButtonTapped
    }
    
    @Dependency(\.dismiss) private var dismiss

    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            
            switch action {
            case let .episodeIdSelected(id):
                state.episodeDetails = .init(episodeId: id)
                return .none
                
            case .episodeDetails:
                 return .none
                
            case .dismissButtonTapped:
                return .run { _ in await self.dismiss() }
            }
            
        }
        .ifLet(\.$episodeDetails, action: \.episodeDetails) {
            EpisodeDetailsReducer()
        }
    }
}
