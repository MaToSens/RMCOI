//
//  CircularIconView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct CircularIconView: View {
    private let systemName: String
    private let font: Font
    
    init(
        systemName: String,
        font: Font = .headline
    ) {
        self.systemName = systemName
        self.font = font
    }
    
    var body: some View {
        Image(systemName: systemName)
            .font(font)
            .padding(10)
            .background(
                Circle()
                    .fill(.white)
                    .shadow(radius: 1)
            )
    }
}

#Preview {
    CircularIconView(systemName: "heart.fill")
}
