//
//  RMCOIApp.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import SwiftUI

@main
struct RMCOIApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersListView(
                store: Store(
                    initialState: CharactersListReducer.State(),
                    reducer: { CharactersListReducer() }
                )
            )
        }
    }
}
