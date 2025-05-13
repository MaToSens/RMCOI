//
//  CharacterDetailsView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//



import ComposableArchitecture
import SwiftUI

struct CharacterDetailsView: View {
    let store: StoreOf<CharacterDetailsReducer>
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        VStack {
            Text(store.character.name)
        }
    }
}
