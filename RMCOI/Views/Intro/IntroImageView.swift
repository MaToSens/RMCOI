//
//  IntroImageView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct IntroView: View {
    @State private var animationTrigger = false
    let onTap: () -> Void
 
    var body: some View {
        VStack {
            Image("intro")
                .resizable()
                .scaledToFit()
                .scaleEffect(animationTrigger ? 1.05 : 0.95)
                .animation(
                    .easeInOut(duration: 1.5)
                    .repeatForever(autoreverses: true),
                    value: animationTrigger
                )
                .onAppear { animationTrigger = true }
                .onTapGesture { onTap() }
            
            Text("Wskakuj Morty, nie ma czasu na wyjaśnienia! Musimy znaleźć wszystkich z wymiaru C-137 zanim będzie za późno!")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    IntroView { }
}
