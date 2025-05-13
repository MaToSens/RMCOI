//
//  Characters.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

struct Character: APIObject, Identifiable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location?
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var characterStatus: Status {
        Status(rawValue: status.lowercased()) ?? .unknown
    }
}

struct Location: Codable, Equatable {
    let name: String
    let url: String
}
