//
//  FeedbackView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct FeedbackView: View {
    let imageName: String
    let title: String
    let description: String
    let detailText: String
    let buttonText: String
    let onTapButton: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            circleImage
            titleText
            descriptionText
            detailsText
            actionButton
        }
        .padding()
        .multilineTextAlignment(.center)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var circleImage: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(.white, lineWidth: 2)
                    .shadow(radius: 1)
            )
    }
    
    private var titleText: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.orange)
    }
    
    private var descriptionText: some View {
        Text(description)
            .font(.headline)
            .padding(.horizontal)
    }
    
    private var detailsText: some View {
        Text(.init(detailText))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.horizontal, 40)
    }
    
    private var actionButton: some View {
        Button {
            onTapButton()
        } label: {
            Text(buttonText)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(.green)
                .cornerRadius(10)
        }
        .padding(.top)
    }
    
    static func emptyView(onClearFilters: @escaping () -> Void) -> FeedbackView {
        FeedbackView(
            imageName: "feedback_empty",
            title: "Oh jeez, Rick!",
            description: "Nie ma żadnych postaci pasujących do tych kryteriów!",
            detailText: "M-może spróbuj innego zapytania? Wiesz... to... to nie jest takie proste znaleźć kogoś w multiwersum.",
            buttonText: "Pokaż wszystkie postaci",
            onTapButton: onClearFilters
        )
    }
    
    static func errorView(_ errorDescription: String, onRetry: @escaping () -> Void) -> FeedbackView {
        FeedbackView(
            imageName: "feedback_error",
            title: "To miała być prosta misja, Morty!",
            description: "Ten wymiar dosłownie się rozpada: \(errorDescription)",
            detailText: " Teraz będziemy musieli wszystko naprawić!!",
            buttonText: "Uruchom portal ponownie!",
            onTapButton: onRetry
        )
    }
}
