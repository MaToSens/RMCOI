//
//  Array+Extensions.swift
//  RMCOI
//
//  Created by MaTooSens on 13/05/2025.
//

import Foundation

extension Array where Element == Int {
    func joinedAsString(separator: String = ",") -> String {
        return self.map { String($0) }.joined(separator: separator)
    }
}
