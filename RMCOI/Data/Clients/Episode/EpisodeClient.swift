//
//  EpisodeClient.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import Dependencies
import Foundation

fileprivate enum Endpoint: EndpointInterface {
    case episodeById(id: String)
    
    var components: [String] {
        switch self {
        case .episodeById(let id): [id]
        }
    }
    
    var parameters: [String : Any] { [:] }
    
    static let base: String = "/episode"
}

struct EpisodeClient {
    var fetchEpisode: @Sendable (String) async throws -> Episode
}

extension EpisodeClient: DependencyKey {
    static var liveValue: EpisodeClient {
        @Dependency(\.networkClient) var networkClient
        
        return EpisodeClient(
            fetchEpisode: {
                let endpoint = Endpoint.episodeById(id: $0)
                return try await networkClient.fetch(endpoint, withKeyDecodingStrategy: .convertFromSnakeCase)
            }
        )
    }
}

extension DependencyValues {
    var episodeClient: EpisodeClient {
        get { self[EpisodeClient.self] }
        set { self[EpisodeClient.self] = newValue }
    }
}
