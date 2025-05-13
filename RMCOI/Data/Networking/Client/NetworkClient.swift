//
//  NetworkClient.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Dependencies
import ComposableArchitecture
import Foundation

@DependencyClient
struct NetworkClient: Sendable {
    func fetch<Endpoint: EndpointInterface, Response: Codable>(
        _ endpoint: Endpoint,
        withKeyDecodingStrategy keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) async throws -> Response {
        try await URLSession.data(from: endpoint, keyDecodingStrategy: keyDecodingStrategy)
    }
    
    func fetchResponse<Endpoint: EndpointInterface, Object: Codable>(
        endpoint: Endpoint,
        withKeyDecodingStrategy keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) async throws -> APIResponse<Object> {
        try await URLSession.data(from: endpoint, keyDecodingStrategy: keyDecodingStrategy)
    }
}

extension NetworkClient: DependencyKey {
    static var liveValue: NetworkClient {
        NetworkClient()
    }
}

extension DependencyValues {
    var networkClient: NetworkClient {
        get { self[NetworkClient.self] }
        set { self[NetworkClient.self] = newValue }
    }
}
