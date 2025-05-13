//
//  FavoriteCharactersClient.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import ComposableArchitecture
import Dependencies
import Foundation

struct FavoriteCharactersClient {
    private static let key = "favoriteCharacterIDs"
    private static let defaults = UserDefaults.standard
    
    var toggleFavorite: @Sendable (Int) -> Void
    var isFavorite: @Sendable (Int) -> Bool
    var fetchFavoriteCharacters: @Sendable () -> Set<Int>
}

extension FavoriteCharactersClient: DependencyKey {
    static var liveValue: FavoriteCharactersClient {
        
        return FavoriteCharactersClient(
            toggleFavorite: {
                var favorites = load()
                
                if favorites.contains($0) {
                    favorites.remove($0)
                } else {
                    favorites.insert($0)
                }
                
                save(favorites)
            },
            isFavorite: {
                let favorites = load()
                return favorites.contains($0)
            },
            fetchFavoriteCharacters: load
        )
    }
}

private extension FavoriteCharactersClient {
    static func save(_ favorites: Set<Int>) {
        defaults.set(Array(favorites), forKey: key)
    }
    
    @Sendable
    static func load() -> Set<Int> {
        let array = defaults.array(forKey: key) as? [Int] ?? []
        return Set(array)
    }
}

extension DependencyValues {
    var favoriteCharactersClient: FavoriteCharactersClient {
        get { self[FavoriteCharactersClient.self] }
        set { self[FavoriteCharactersClient.self] = newValue }
    }
}
