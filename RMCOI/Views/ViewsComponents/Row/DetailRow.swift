//
//  DetailRow.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct DetailRow: View {
    let title: String
    let value: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text(title.capitalized)
                .font(.headline)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Text(value ?? "Unknown")
                .font(.subheadline)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
