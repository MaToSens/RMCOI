//
//  ToolbarCircularButton.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//


import SwiftUI

struct ToolbarCircularButton: ToolbarContent {
    private let systemName: String
    private let placement: ToolbarItemPlacement
    private let action: () -> Void
    
    init(
        systemName: String,
        placement: ToolbarItemPlacement = .topBarTrailing,
        action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.placement = placement
        self.action = action
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action) {
                CircularIconView(
                    systemName: systemName,
                    font: .footnote
                )
            }
        }
    }
}
