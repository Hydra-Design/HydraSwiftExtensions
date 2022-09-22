//
//  File.swift
//  
//
//  Created by Lukas Simonson on 6/23/22.
//

import Foundation

extension Array where Element : Equatable {
    
    /// Removes duplicate items from this `Array`
    ///
    /// - Returns: An `Array` of all the objects removed from the given `Array`
    /// - Version: Beta 0.1
    @discardableResult
    mutating func cleaned() -> Array< Element > {
        
        var cleanedArray = Array< Element >()
        var dirtyItems = Array< Element >()
        
        self.forEach { item in
            if !cleanedArray.contains( item ) {
                cleanedArray.append( item )
            } else { dirtyItems.append( item ) }
        }
        self = cleanedArray
        return dirtyItems
    }
}
