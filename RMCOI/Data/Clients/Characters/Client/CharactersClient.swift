//
//  Endpoint.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import Dependencies

fileprivate enum Endpoint: EndpointInterface {
    case characterById(id: Int) // NOTE: Dodano tylko do zaprezentowania funkcjonalności endpointów
    case charactersByMultipleIds(ids: [Int]) // NOTE: Dodano tylko do zaprezentowania funkcjonalności endpointów
    case charactersPage(page: Int)
    case charactersFilter(filters: CharactersFilters)
    
    var components: [String] {
        switch self {
        case let .characterById(id): ["\(id)"]
        case let .charactersByMultipleIds(ids): [ids.joinedAsString()]
        default: []
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .charactersPage(page): ["page": page]
        case let .charactersFilter(filters): filters.asParameters()
        default: [:]
        }
    }
    
    static let base: String = "/character"
}

struct CharacterClient {
    var fetchCharacterById: @Sendable (Int) async throws -> Character
    var fetchCharactersByIds: @Sendable ([Int]) async throws -> [Character]
    var fetchCharacters: @Sendable (Int) async throws -> APIResponse<Character>
    var fetchCharactersByFilters: @Sendable (CharactersFilters) async throws -> APIResponse<Character>
}

extension CharacterClient: DependencyKey {
    static var liveValue: CharacterClient {
        @Dependency(\.networkClient) var networkClient
        
        return CharacterClient(
            fetchCharacterById: {
                let endpoint = Endpoint.characterById(id: $0)
                return try await networkClient.fetch(endpoint)
            },
            fetchCharactersByIds: {
                let endpoint = Endpoint.charactersByMultipleIds(ids: $0)
                return try await networkClient.fetch(endpoint)
            },
            fetchCharacters: {
                let endpoint = Endpoint.charactersPage(page: $0)
                return try await networkClient.fetchResponse(endpoint: endpoint)
            },
            fetchCharactersByFilters: {
                let endpoint = Endpoint.charactersFilter(filters: $0)
                return try await networkClient.fetchResponse(endpoint: endpoint)
            }
        )
    }
}

extension DependencyValues {
    var characterClient: CharacterClient {
        get { self[CharacterClient.self] }
        set { self[CharacterClient.self] = newValue }
    }
}
