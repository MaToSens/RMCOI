//
//  APIResponse.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

protocol APIObject: Codable, Equatable { }

struct APIResponse<Object: APIObject>: Codable, Equatable {
    let info: Info
    let results: [Object]
    
    init(
        info: Info = Info(),
        results: [Object] = []
    ) {
        self.info = info
        self.results = results
    }
}

struct Info: Codable, Equatable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    init(
        count: Int = 0,
        pages: Int = 0,
        next: String? = nil,
        prev: String? = nil
    ) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}
