//
//  File.swift
//  
//
//  Created by Lukas Simonson on 6/23/22.
//

import Foundation

public extension Array where Element : Equatable {
    
    /// Returns this `Array` with all duplicate items removed.
    ///
    /// - Returns: An `Array` with only unique items.
    /// - Version: Beta 0.2
    func cleaned() -> [Element] {
        var seen = [Element]()
        return self.filter { element in
            if seen.contains(element) {
                return false
            } else {
                seen.append(element)
                return true
            }
        }
    }
    
    /// Removes duplicate items from this `Array`.
    ///
    /// - Returns: An `Array` of all the duplicate objects removed from the given `Array`.
    /// - Version: Beta 0.2
    @discardableResult
    mutating func clean() -> [Element] {

        var cleanArray = [Element]()
        var dirtyItems = [Element]()
        
        self.forEach { item in
            if !cleanArray.contains( item ) {
                cleanArray.append( item )
            } else { dirtyItems.append( item ) }
        }
        
        self = cleanArray
        return dirtyItems
    }
}
