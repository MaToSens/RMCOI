//
//  CharactersFilters.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import SwiftUI

struct CharactersFilters: Equatable {
    var page: Int
    var name: String?
    var status: Status?
    var gender: Gender?
    var species: Species?
    
    init(
        page: Int = 1,
        name: String? = nil,
        status: Status? = nil,
        gender: Gender? = nil,
        species: Species? = nil
    ) {
        self.page = page
        self.name = name
        self.status = status
        self.gender = gender
        self.species = species
    }
}

extension CharactersFilters {
    func asParameters() -> [String: Any] {
        let optionalParameters: [String: Any?] = [
            "page": page,
            "name": name,
            "status": status?.rawValue,
            "species": species?.rawValue,
            "gender": gender?.rawValue
        ]
        
        let parameters: [String: Any] = optionalParameters.compactMapValues { $0 }
        
        return parameters
    }
}

extension CharactersFilters {
    func updated(_ filter: CharactersFilter) -> CharactersFilters {
        var copy = self
        
        switch filter {
        case let .status(status): copy.status = (copy.status == status) ? nil : status
        case let .gender(gender): copy.gender = (copy.gender == gender) ? nil : gender
        case let .species(species): copy.species = (copy.species == species) ? nil : species
        }
        
        return copy
    }
}
