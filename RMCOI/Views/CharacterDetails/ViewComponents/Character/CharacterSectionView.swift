//
//  EpisodeSectionView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct EpisodeSectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            Text(title)
                .font(.headline)
                .fontWeight(.heavy)
            
            content
        }
        .padding(.horizontal)
    }
}
