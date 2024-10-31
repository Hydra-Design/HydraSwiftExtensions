//
//  Color+Components.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import SwiftUI

extension Color {
    /// The RGBA values of the current color.
    public var components: Color.Components {
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return Components(redFloat: r, greenFloat: g, blueFloat: b, alphaFloat: a)
    }
    
    /// A type that represents the values that make up a Color in RGBA format.
    public struct Components: Codable, Equatable, Hashable {
        public let redFloat: CGFloat
        public let greenFloat: CGFloat
        public let blueFloat: CGFloat
        public let alphaFloat: CGFloat
        
        public var red: Int { Int(redFloat * 255) }
        public var green: Int { Int(greenFloat * 255) }
        public var blue: Int { Int(blueFloat * 255) }
        public var alpha: Int { Int(alphaFloat * 255) }
        
        public var rgbaHexadecimalValue: UInt32 {
            let hexValue: UInt32 = [redFloat, greenFloat, blueFloat, alphaFloat].reduce(0) { pr, v in
                return (pr << 8) | UInt32(clamping: lroundf(Float(v) * 255))
            }
            
            return hexValue
        }
        
        public var luminance: Int {
            Int((21.26 * redFloat) + (71.52 * greenFloat) + (7.22 * blueFloat))
        }
        
        public var complementary: Color.Components {
            Color.Components(
                redFloat: CGFloat(255 - red) / 255,
                greenFloat: CGFloat(255 - green) / 255,
                blueFloat: CGFloat(255 - blue) / 255,
                alphaFloat: alphaFloat
            )
        }
        
        public var color: Color {
            Color(red: redFloat, green: greenFloat, blue: blueFloat, opacity: alphaFloat)
        }
    }
}
