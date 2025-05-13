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
            CharacterImageView(store.character.image)
            
            ScrollView {
                CharacterStatusView(store.character, font: .title)
                
                buildCharacterTypeSection(character: store.character)
             
                buildEpisodesSection()
            }
        }
        .onAppear { store.send(.onAppear) }
        .ignoresSafeArea(edges: .top)
        .toolbar(content: buildToolbarContent)
        .navigationBarBackButtonHidden()
    }
    
    private func buildCharacterTypeSection(character: Character) -> some View {
        CharacterSectionView("Character Type") {
            DetailRow(title: "Gender", value: character.gender)
            DetailRow(title: "Species", value: character.species)
            DetailRow(title: "Origin", value: character.origin?.name)
            DetailRow(title: "Location", value: character.location?.name)
        }
    }
    
    private func buildEpisodesSection() -> some View {
        CharacterSectionView("Episodes") {
            LazyVGrid(columns: columns){
                ForEach(store.episodeIDs, id: \.self) { episodeId in
                    
                    NavigationLinkStore(
                        store.scope(state: \.$episodeDetails, action: \.episodeDetails),
                        id: episodeId
                    ) {
                        store.send(.episodeIdSelected(episodeId))
                    } destination: { store in
                        EpisodeDetailsView(store: store)
                    } label: {
                        buildEpisodeCellView(episodeId: episodeId)
                    }
                    
                }
            }
        }
    }
    
    private func buildEpisodeCellView(episodeId: String) -> some View {
        VStack {
            Image(systemName: "play.tv.fill")
            
            Text("Episode: " + episodeId)
        }
        .font(.footnote)
        .foregroundColor(.black)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 1)
        )
    }
    
    @ToolbarContentBuilder
    private func buildToolbarContent() -> some ToolbarContent {
        ToolbarCircularButton(systemName: "chevron.left", placement: .topBarLeading) {
            store.send(.dismissButtonTapped)
        }
        
        ToolbarCircularButton(systemName: store.isFavorite ? "heart.fill" : "heart", placement: .topBarTrailing) {
            store.send(.toggleFavorite)
        }
    }
}
