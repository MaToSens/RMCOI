//
//  JSONDecoder+Extensions.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

extension JSONDecoder {
    convenience init(withKeyDecodingStrategy keyDecodingStrategy: KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = keyDecodingStrategy
    }
}
