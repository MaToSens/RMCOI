//
//  CharacterImageView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Kingfisher
import SwiftUI

struct CharacterImageView: View {
    private let imageURL: URL?
    
    init(_ image: String) {
        self.imageURL = URL(string: image)
    }
    
    var body: some View {
        KFImage(imageURL)
            .placeholder { ProgressView() }
            .fade(duration: 0.3)
            .resizable()
            .scaledToFit()
    }
}
