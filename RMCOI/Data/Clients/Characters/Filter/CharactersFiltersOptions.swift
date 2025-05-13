//
//  CharacterFilter.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

enum CharactersFilter: Equatable {
    case status(Status)
    case gender(Gender)
    case species(Species)
}

enum Status: String, CaseIterable, Equatable {
    case alive
    case dead
    case unknown
    
    var color: Color {
        switch self {
        case .alive: return .green
        case .dead: return .red
        case .unknown: return .gray
        }
    }
}

enum Gender: String, CaseIterable, Equatable {
    case female, male, genderless, unknown
}

// NOTE: Poniżej znajduje się tylko fragment pełnej listy gatunków, dodany w celu pokazania działania filtrów
enum Species: String, CaseIterable, Equatable {
    case human, alien, poopybutthole, animal, cronenberg, disease, humanoid, robot
    case mythologicalCreature = "Mythological Creature"
}
