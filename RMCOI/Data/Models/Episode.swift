//
//  Episode.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

struct Episode: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let airDate: String?
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
