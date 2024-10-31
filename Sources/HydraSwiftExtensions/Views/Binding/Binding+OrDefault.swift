//
//  Binding+OrDefault.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import SwiftUI

extension Binding {
    // Creates a new binding unwrapping the provided bindings value if it is nil.
    init(_ binding: Binding<Value?>, or defaultValue: Value) {
        self = Binding(
            get: { binding.wrappedValue ?? defaultValue },
            set: { binding.wrappedValue = $0 }
        )
    }
}
