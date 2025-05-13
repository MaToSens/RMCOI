//
//  CharactersListReducer.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct CharactersListReducer {
    
    enum ContentState: Equatable {
        case intro
        case loading
        case loaded([Character])
        case failed(String)
    }
    
    @ObservableState
    struct State: Equatable {
        var info: Info
        var contentState: ContentState
        var favoriteIds: Set<Int>
        var hasMorePages: Bool { info.next != nil }
        
        // Filter
        var filters: CharactersFilters
        var searchTerm: String
        var isFiltersPanelVisible: Bool
        
        // Navigation
        @Presents var characterDetails: CharacterDetailsReducer.State?
        
        init(
            info: Info = .init(),
            contentState: ContentState = .intro,
            favoriteIds: Set<Int> = [],
            filters: CharactersFilters = .init(),
            searchTerm: String = "",
            isFiltersPanelVisible: Bool = false,
            characterDetails: CharacterDetailsReducer.State? = nil
        ) {
            self.info = info
            self.contentState = contentState
            self.favoriteIds = favoriteIds
            self.filters = filters
            self.searchTerm = searchTerm
            self.isFiltersPanelVisible = isFiltersPanelVisible
            self.characterDetails = characterDetails
        }
    }
    
    enum Action: Equatable, BindableAction {
        // Binding
        case binding(BindingAction<State>)
        
        // Lifecycle actions
        case enterCharactersList
        case returnToIntro
        case loadFavoritesCharacters
        
        // Data-related actions
        case responseReceived(APIResponse<Character>)
        case contentLoaded([Character])
        case contentLoadFailed(String)
        case loadNextPage
        
        // Filter actions
        case toggleFilterPanel
        case applyFilters
        case clearFilters
        case updateFilter(CharactersFilter)
        
        // UI actions
        case submitSearch
        case clearSearch
        case clearAll
        
        // Navigation actions
        case characterSelected(Character)
        case characterDetails(PresentationAction<CharacterDetailsReducer.Action>)
    }
    
    @Dependency(\.characterClient) private var characterClient
    @Dependency(\.favoriteCharactersClient) private var favoriteCharactersClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            
            switch action {
                // Binding
            case .binding:
                return .none
                
                // Lifecycle actions
            case .enterCharactersList:
                state.contentState = .loading
                return .concatenate(
                    .send(.loadFavoritesCharacters),
                    .run { await fetchInitialCharacters($0) }
                )
                
            case .returnToIntro:
                state.resetFilters()
                state.contentState = .intro
                return .none
                
            case .loadFavoritesCharacters:
                state.favoriteIds = favoriteCharactersClient.fetchFavoriteCharacters()
                return .none
                
                // Data-related actions
            case let .responseReceived(response):
                state.info = response.info
                
                switch state.contentState {
                case let .loaded(existingCharacters):
                    return .send(.contentLoaded(existingCharacters + response.results))
                default:
                    return .send(.contentLoaded(response.results))
                }
                
            case let .contentLoaded(characters):
                state.contentState = .loaded(characters)
                return .none
                
            case let .contentLoadFailed(error):
                state.contentState = .failed(error)
                return .none
                
            case .loadNextPage:
                guard state.info.next != nil
                else { return .none }
                
                state.filters.page += 1
                let filters = state.filters
                
                return .run { await fetchPagingCharacters(filters, send: $0) }
                
                // Filter actions
            case .toggleFilterPanel:
                state.isFiltersPanelVisible.toggle()
                return state.isFiltersPanelVisible ? .none : .send(.applyFilters)
                
            case .applyFilters:
                state.contentState = .loading
                let filters = state.filters
                return .run { await fetchCharactersByFilters(filters, send: $0) }
                
            case .clearFilters:
                state.filters = .init(name: state.searchTerm)
                return .none
                
            case .updateFilter(let filters):
                state.filters = state.filters.updated(filters)
                return .none
                
                // UI actions
            case .submitSearch:
                state.filters.name = state.searchTerm
                return .send(.applyFilters)
                
            case .clearSearch:
                state.searchTerm = ""
                state.filters.name = ""
                return .send(.applyFilters)
                
            case .clearAll:
                state.resetFilters()
                return .send(.applyFilters)
                
                // Navigation actions
            case let .characterSelected(character):
                state.characterDetails = .init(character: character)
                return .none
                
            case .characterDetails(.dismiss):
                return .send(.loadFavoritesCharacters)
                
            case .characterDetails:
                return .none
            }
            
        }
        .ifLet(\.$characterDetails, action: \.characterDetails) {
            CharacterDetailsReducer()
        }
    }
    
    private func fetchInitialCharacters(_ send: Send<Action>) async {
        do {
            let response = try await self.characterClient.fetchCharacters(1)
            await send(.responseReceived(response))
        } catch {
            await send(.contentLoadFailed(error.localizedDescription))
        }
    }
    
    private func fetchCharactersByFilters(_ filters: CharactersFilters, send: Send<Action>) async {
        do {
            let response = try await self.characterClient.fetchCharactersByFilters(filters)
            await send(.responseReceived(response))
        } catch HTTPError.resourceNotFound {
            let emptyResponse = APIResponse<Character>()
            await send(.responseReceived(emptyResponse))
        } catch {
            await send(.contentLoadFailed(error.localizedDescription))
        }
    }
    
    private func fetchPagingCharacters(_ filters: CharactersFilters, send: Send<Action>) async {
        do {
            let response = try await self.characterClient.fetchCharactersByFilters(filters)
            await send(.responseReceived(response))
        } catch {
            await send(.contentLoadFailed(error.localizedDescription))
        }
    }
}

extension CharactersListReducer.State {
    mutating func resetFilters() {
        searchTerm = ""
        filters = .init()
    }
}
