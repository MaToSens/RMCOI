//
//  URLSession+Extensions.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

extension URLSession {
    static func data<Endpoint: EndpointInterface, Reposnse: Decodable>(
        from endpoint: Endpoint,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    ) async throws -> Reposnse {
        let data = try await fetchData(from: endpoint)
        return try decode(data, keyDecodingStrategy: keyDecodingStrategy)
    }
    
    static func fetchData<Endpoint: EndpointInterface>(from endpoint: Endpoint) async throws -> Data {
        let url = try URLBuilder.buildURL(from: endpoint)
        return try await executeRequest(from: url)
    }
    
    private static func executeRequest(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            return try validateResponse(data: data, response: response)
        } catch {
            throw error is HTTPError ? error : HTTPError.networkError(error.localizedDescription)
        }
    }
    
    private static func validateResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse
        else { throw HTTPError.invalidResponse }
    
        switch httpResponse.statusCode {
        case 200...299:
            return data
        case 404:
            throw HTTPError.resourceNotFound
        default:
            throw HTTPError.invalidStatusCode(httpResponse.statusCode)
        }
    }
    
    private static func decode<Response: Decodable>(
        _ data: Data,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy
    ) throws -> Response {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw HTTPError.invalidDecoding(error.localizedDescription)
        }
    }
}

fileprivate struct URLBuilder {
    static let baseURL: String = "https://rickandmortyapi.com/api"
    
    static func buildURL<Endpoint: EndpointInterface>(from endpoint: Endpoint) throws -> URL {
        let path = buildPath(from: endpoint)
        let urlString = baseURL.appending(path)
        
        guard let url = URL(string: urlString, with: endpoint.parameters)
        else { throw HTTPError.invalidParameters }
        
        return url
    }
    
    static func buildPath<Endpoint: EndpointInterface>(from endpoint: Endpoint) -> String {
        var components = endpoint.components
        components.insert(Endpoint.base, at: 0)
        
        return components.map({$0}).joined(separator: "/")
    }
}
