//
//  FiltersSheetView.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import SwiftUI

struct FiltersSheetView: View {
    let store: StoreOf<CharactersListReducer>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    filtersSection
                    clearFiltersButtons
                }
                .padding()
            }
            .navigationTitle("Filtrs")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: toolbarContent)
        }
    }
    
    private var filtersSection: some View {
        Group {
            FilterSectionView(
                title: "Status",
                items: Status.allCases,
                selectedItem: store.filters.status,
                onItemSelected: { store.send(.updateFilter(.status($0))) }
            )
            
            FilterSectionView(
                title: "Gender",
                items: Gender.allCases,
                selectedItem: store.filters.gender,
                onItemSelected: { store.send(.updateFilter(.gender($0))) }
            )
            
            FilterSectionView(
                title: "Species",
                items: Species.allCases,
                selectedItem: store.filters.species,
                onItemSelected: { store.send(.updateFilter(.species($0))) }
            )
        }
    }
    
    private var clearFiltersButtons: some View {
        VStack(spacing: 5) {
            Button {
                store.send(.toggleFilterPanel)
            } label: {
                Text("Apply filters")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(6)
            }
            
            Button {
                store.send(.clearFilters)
            } label: {
                Text("Clear filters")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(6)
                    .shadow(radius: 1)
            }
        }
        .padding(.top)
    }
    
    private func toolbarContent() -> some ToolbarContent {
        ToolbarCircularButton(systemName: "xmark", placement: .topBarTrailing) {
            store.send(.toggleFilterPanel)
        }
    }
}

