//
//  CharacterStatusView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct CharacterStatusView: View {
    private let character: Character
    private let font: Font
    
    init(_ character: Character, font: Font = .footnote) {
        self.character = character
        self.font = font
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(character.characterStatus.color)
                .frame(width: 15)
            
            Text(character.name.uppercased())
                .font(font)
                .foregroundColor(.black)
                .lineLimit(1)
        }
    }
}
