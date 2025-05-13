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
        
        init(character: Character) {
            self.character = character
        }
    }
    
    enum Action: Equatable {
        case onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none
            }
        }
    }
}
