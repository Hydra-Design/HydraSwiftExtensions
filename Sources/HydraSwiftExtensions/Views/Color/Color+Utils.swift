//
//  Color+Utils.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import SwiftUI

extension Color {
    
    /// The luminance of the current color.
    public var luminance: Int {
        self.components.luminance
    }
    
    /// A color that will overlay well on top of the current color.
    ///
    /// > NOTE: Either `Color.Black` or `Color.white` based on luminance.
    ///
    public var overlayedTextColor: Color {
        luminance > 50 ? .black : .white
    }
    
    /// The complementary color of the current color.
    public var complementaryColor: Color {
        self.components.complementary.color
    }
}
