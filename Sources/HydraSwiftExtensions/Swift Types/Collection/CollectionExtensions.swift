//
//  CollectionExtensions.swift
//  
//
//  Created by Paul Hegarty.
//  Documented by Lukas Simonson.
//

import Foundation

@available(macOS 10.15, *)
@available( iOS 13.0, * )
extension Collection where Element: Identifiable {
    
    /// Gets the index of the first item matching the given item.
    ///
    /// - Returns: An Optional `Index` value.
    ///
    /// - Version: 1.0
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
}

@available(macOS 10.15, *)
@available( iOS 13.0, * )
extension RangeReplaceableCollection where Element: Identifiable {
    
    /// Removes the given item from this `Array`
    ///
    /// - Version: 1.0
    mutating func remove(_ element: Element) {
        if let index = index(matching: element) {
            remove(at: index)
        }
    }
    
    subscript(_ element: Element) -> Element {
        get {
            if let index = index(matching: element) {
                return self[index]
            } else {
                return element
            }
        }
        set {
            if let index = index(matching: element) {
                replaceSubrange(index...index, with: [newValue])
            }
        }
    }
}
