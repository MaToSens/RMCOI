//
//  CharacterCellView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//


import SwiftUI

struct CharacterCellView: View {
    private let character: Character
    private let isFavorite: Bool
    
    init( _ character: Character, isFavorite: Bool = false) {
        self.character = character
        self.isFavorite = isFavorite
    }

    var body: some View {
        VStack {
            CharacterImageView(character.image)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white, lineWidth: 2)
                        .shadow(radius: 1)
                )
                .overlay(alignment: .topTrailing, content: buildFavoriteIconContent)
            
            CharacterStatusView(character)
        }
        .padding(.vertical, 10)
    }
    
    @ViewBuilder
    private func buildFavoriteIconContent() -> some View {
        if isFavorite {
            CircularIconView(systemName: "heart.fill")
        }
    }
}
