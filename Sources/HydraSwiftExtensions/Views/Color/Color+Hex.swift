//
//  Color+Hex.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import SwiftUI

extension Color {
    
    /// Creates a new `SwiftUI.Color` using a `ColorHex` value.
    public init(hex: ColorHex) {
        switch hex {
            case .rgb(let rgb):
                self.init(rgb: rgb)
            case .rgba(let rgba):
                self.init(rgba: rgba)
        }
    }
    
    /// Creates a new `SwiftUI.Color` using a `UInt32` value as RGB.
    public init(rgb: UInt32) {
        self.init(rgba: (rgb << 8) | 0xFF)
    }
    
    /// Creates a new `SwiftUI.Color` using a `UInt32` value as RGBA.
    public init(rgba: UInt32) {
        self.init(
            red:     CGFloat((rgba & 0xFF000000) >> 24) / 255.0,
            green:   CGFloat((rgba & 0x00FF0000) >> 16) / 255.0,
            blue:    CGFloat((rgba & 0x0000FF00) >>  8) / 255.0,
            opacity: CGFloat( rgba & 0x000000FF)        / 255.0
        )
    }
    
    /// The `ColorHex` value that represents the current color.
    ///
    /// > NOTE: Will always be ColorHex.rgba
    ///
    public var hex: ColorHex {
        ColorHex.rgba(self.components.rgbaHexadecimalValue)
    }
}

public enum ColorHex: Codable, Equatable, Hashable {
    
    /// An RGB Color Value.
    case rgb(UInt32)
    
    /// An RGBA Color Value.
    case rgba(UInt32)
    
    /// The Hexadecimal value of this `ColorHex`.
    public var value: UInt32 {
        switch self {
            case .rgb(let value), .rgba(let value): return value
        }
    }
    
    /// Converts this `ColorHex` to an `.rgb` case if it is not already.
    public func asRGB() -> Self {
        switch self {
            case .rgb: return self
            case .rgba(let value): return .rgb(value >> 8)
        }
    }
    
    /// Converts this `ColorHex` to an `.rgba` case if it is not already.
    public func asRGBA() -> Self {
        switch self {
            case .rgb(let value): return .rgba(value << 8 | 0xFF)
            case .rgba: return self
        }
    }
}

public extension ColorHex {
    
    /// Creates a random `ColorHex` value.
    static var random: ColorHex { self.rgb(UInt32.random(in: 0x000000...0xFFFFFF)) }
}
