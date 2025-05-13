//
//  CharactersListView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import SwiftUI

struct CharactersListView: View {
    @ComposableArchitecture.Bindable var store: StoreOf<CharactersListReducer>
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        WithPerceptionTracking {
            switch store.contentState {
            case .intro:
                IntroView { store.send(.enterCharactersList) }
            case .loading:
                ProgressView()
                    .scaleEffect(1.2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case let .loaded(characters):
                loadedContentView(characters)
            case let .failed(errorDescription):
                FeedbackView.errorView(errorDescription) { store.send(.clearAll) }
            }
        }
    }
        
    private func loadedContentView(_ characters: [Character]) -> some View {
        NavigationView {
            ScrollView {
                if !characters.isEmpty {
                    buildCharacterGridView(for: characters)
                } else {
                    FeedbackView.emptyView { store.send(.clearAll) }
                }
                
                buildLoadingIndicatorView()
            }
            .navigationTitle("Centrala Postaci")
            .toolbar(content: buildToolbarContent)
            .searchable(text: $store.searchTerm, prompt: "Szukasz kogoś Morty?")
            .onSubmit(of: .search) { store.send(.submitSearch)}
            .onChange(of: store.searchTerm, perform: handleSearchTermChange)
            .fullScreenCover(
                isPresented: $store.isFiltersPanelVisible,
                content: { FiltersSheetView(store: store) }
            )
        }
    }
    
    private func buildCharacterGridView(for characters: [Character]) -> some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(characters) { character in
                NavigationLinkStore(store.scope(state: \.$characterDetails, action: \.characterDetails), id: character.id) {
                    store.send(.characterSelected(character))
                } destination: { store in
                    CharacterDetailsView(store: store)
                } label: {
                    CharacterCellView(character, isFavorite: store.favoriteIds.contains(character.id))
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func buildLoadingIndicatorView() -> some View {
        if store.hasMorePages {
            LazyVStack {
                ProgressView()
                    .onAppear { store.send(.loadNextPage) }
            }
        }
    }
    
    @ToolbarContentBuilder
    private func buildToolbarContent() -> some ToolbarContent {
        ToolbarCircularButton(systemName: "eye.slash", placement: .topBarLeading) {
            store.send(.returnToIntro)
        }
        
        ToolbarCircularButton(systemName: "gear", placement: .topBarTrailing) {
            store.send(.toggleFilterPanel)
        }
    }
    
    private func handleSearchTermChange(_ value: String) {
        guard value.isEmpty else { return }
        store.send(.clearSearch)
    }
}

#Preview {
    CharactersListView(
        store: Store(
            initialState: CharactersListReducer.State(),
            reducer: { CharactersListReducer() }
        )
    )
}
