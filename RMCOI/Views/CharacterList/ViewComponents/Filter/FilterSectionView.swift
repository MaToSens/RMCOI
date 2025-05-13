//
//  FilterSectionView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI
import SwiftUIFlowLayout

struct FilterSectionView<Filter: RawRepresentable & Hashable & CaseIterable>: View where Filter.RawValue == String {
    let title: String
    let items: Filter.AllCases
    let selectedItem: Filter?
    let onItemSelected: (Filter) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            FlowLayout(
                mode: .scrollable,
                items: Array(items),
                itemSpacing: 4,
                viewMapping: filterPill
            )
        }
    }
    
    @ViewBuilder
    private func filterPill(for item: Filter) -> some View {
        let isSelected = selectedItem == item
        
        Button {
            onItemSelected(item)
        } label: {
            Text(item.rawValue.capitalized)
                .font(.callout)
                .padding(10)
                .foregroundColor(isSelected ? .white : .primary)
                .background(isSelected ? Color.green : Color.gray.opacity(0.2))
                .cornerRadius(6)
        }
    }
}
