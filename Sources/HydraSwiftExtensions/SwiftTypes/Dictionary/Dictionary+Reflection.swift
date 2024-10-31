//
//  DictionaryPlusReflection.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 6/8/22.
//

import Foundation

public extension Dictionary where Key == String, Value == Any {
    
    /// Creates a `Dictionary<String, Any>` that represents the given object.
    init<T>(reflecting object : T) {
        self = Dictionary(uniqueKeysWithValues:
            Mirror(reflecting: object)
                .children
                .compactMap { if let label = $0.label { (label, $0.value) } else { nil } }
        )
    }
}
