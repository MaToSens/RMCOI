//
//  NetworkingInterface.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

protocol EndpointInterface {
    var components: [String] { get }
    var parameters: [String: Any] { get }
    static var base: String { get }
}

protocol APIObject: Codable, Equatable { }

enum HTTPError: Equatable, Error, CustomStringConvertible {
    case invalidURL
    case networkError(String)
    case invalidResponse
    case invalidStatusCode(Int)
    case resourceNotFound
    case invalidDecoding(String)
    case invalidParameters
    
    var description: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .networkError(let error): return "Network error: \(error)"
        case .invalidResponse: return "Invalid HTTP response received"
        case .invalidStatusCode(let code): return "Invalid status code received: \(code)"
        case .resourceNotFound: return "Resource not found"
        case .invalidDecoding(let error): return "Data decoding error: \(error)"
        case .invalidParameters: return "Invalid request parameters"
        }
    }
}
