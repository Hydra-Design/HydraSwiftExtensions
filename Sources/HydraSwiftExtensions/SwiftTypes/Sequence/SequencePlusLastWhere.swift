//
//  File.swift
//  
//
//  Created by Lukas Simonson on 1/11/23.
//

import Foundation

public extension Sequence {
    
    /// Returns the last element of the sequence that satisfies the given predicate.
    ///
    /// - Parameters:
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a `Bool` indicating whether the element is a match.
    ///
    /// - Returns:
    ///   The last element of the sequence that satisfies the predicate, or nil if there is no element that satisfies the predicate.
    func last(where predicate: (Element) -> Bool) -> Element? {
        for item in self.reversed() {
            if predicate(item) {
                return item
            }
        }
        
        return nil
    }
}

public extension Sequence where Element: Equatable {
    
    /// Returns the last element of the sequence that satisfies the given predicate.
    ///
    /// - Parameters:
    ///   - element: An element of the sequence to find.
    ///
    /// - Returns:
    ///   The last element of the sequence that matches the given element, or nil if there is no element that matches the given element.
    func last(matching element: Element) -> Element? {
        last(where: { $0 == element })
    }
}
