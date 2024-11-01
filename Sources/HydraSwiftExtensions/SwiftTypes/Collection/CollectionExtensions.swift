//
//  CollectionExtensions.swift
//  
//
//  Created by Paul Hegarty.
//  Documented by Lukas Simonson.
//

import Foundation

public extension Collection where Element: Equatable {

    /// Gets the indices of all items matching the given item.
    func indices(matching element: Element) -> [Self.Index] {
        self.indices.compactMap { self[$0] == element ? $0 : nil }
    }
    
    /// Gets all elements that match a given element.
    func elements(matching element: Element) -> [Element] {
        self.compactMap { $0 == element ? $0 : nil }
    }
}

public extension RangeReplaceableCollection where Element: Equatable {
    
    /// Removes all items that match the given item.
    mutating func removeMatching(_ element: Element) {
        for index in self.indices(matching: element) {
            remove(at: index)
        }
    }
    
    /// Replaces all items that match the first item with the second item.
    mutating func replaceMatching(_ oldElement: Element, with newElement: Element) {
        for index in indices(matching: oldElement) {
            replaceSubrange(index...index, with: [newElement])
        }
    }
    
    subscript(_ element: Element) -> [Element] {
        get { elements(matching: element) }
    }
}

@available( iOS 13.0, macOS 10.15, * )
public extension Collection where Element: Identifiable {
    
    /// Gets the index of the first item matching the given item based on its ID.
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
    
    /// Gets the index of the first item with the given ID.
    func index(matching id: Element.ID) -> Self.Index? {
        firstIndex(where: { $0.id == id })
    }
}

@available( iOS 13.0, macOS 10.15, * )
public extension RangeReplaceableCollection where Element: Identifiable {
    
    /// Removes the given item from this `Array` based on its ID.
    mutating func remove(_ element: Element) {
        if let index = index(matching: element) {
            remove(at: index)
        }
    }
    
    /// Removes the given item from this `Array` based on the given ID.
    mutating func remove(withID id: Element.ID) {
        if let index = index(matching: id) {
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
