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
        
        init(episodeId: String) {
            self.id = episodeId
        }
    }
    
    enum Action: Equatable {
        case onApper
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .onApper:
                return .none
            }
        }
    }
}
