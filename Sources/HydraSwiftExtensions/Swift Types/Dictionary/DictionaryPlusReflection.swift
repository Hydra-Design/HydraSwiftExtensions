//
//  DictionaryPlusReflection.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 6/8/22.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    /// Creates a `Dictionary<String, Any>` that represents the given object.
    init( reflecting object : Any ) {
        
        let mirror = Mirror(reflecting: object)
        var dict = [ String : Any ]()
        
        mirror.children.forEach { child in
            if let attrName = child.label {
                dict[ attrName ] = child.value
            }
        }
        
        self = dict
    }
}
