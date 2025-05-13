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
        Text(store.id)
    }
    
}
