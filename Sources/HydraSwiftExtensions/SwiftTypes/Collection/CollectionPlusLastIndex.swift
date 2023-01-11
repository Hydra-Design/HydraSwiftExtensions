//
//  File.swift
//  
//
//  Created by Lukas Simonson on 1/11/23.
//

import Foundation

extension Collection {
    
    /// Returns the first index in which an element of the collection satisfies the given predicate.
    ///
    /// - Parameters:
    ///   - predicate: A closure that takes an element as its argument and returns a `Bool` that indicates whether the passed element represents a match.
    ///
    /// - Returns:
    ///   The index of the last element for which the predicate returns true. If no elements in the collection satisfy the given predicate, returns nil.
    ///
    func lastIndex(where predicate: (Element) -> Bool) -> Index? {
        for index in self.indices.reversed() {
            if predicate(self[index]) {
                return index
            }
        }
        return nil
    }
}

extension Collection where Element: Equatable {
    
    /// Returns the first index in which an element of the collection satisfies the given predicate.
    ///
    /// - Parameters:
    ///   - predicate: A closure that takes an element as its argument and returns a `Bool` that indicates whether the passed element represents a match.
    ///
    /// - Returns:
    ///   The index of the last element for which the predicate returns true. If no elements in the collection satisfy the given predicate, returns nil.
    ///
    func lastIndex(of element: Element) -> Index? {
        lastIndex(where: { $0 == element })
    }
}
