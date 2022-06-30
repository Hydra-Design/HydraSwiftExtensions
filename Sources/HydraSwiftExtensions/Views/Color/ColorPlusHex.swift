//
//  File.swift
//  
//
//  Created by Lukas Simonson on 4/27/22.
//

import Foundation
import SwiftUI

#if !os(macOS)
import UIKit
#endif

@available(iOS 14.0, *)
@available(macOS 11, *)
extension Color {
    
    /// Creates a `SwiftUI.Color` object using a Hex Color Code.
    ///
    /// - Parameters:
    ///   - hex: The hex color code string to parse into a Color
    ///
    /// - Version: Beta 0.2
    ///
    public init?( hex: String ) {
        
        var hexSanitized = hex.trimmingCharacters( in: .whitespacesAndNewlines )
        hexSanitized = hexSanitized.replacingOccurrences( of: "#", with: "" )
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner( string: hexSanitized ).scanHexInt64( &rgb ) else { return nil }
        
        if length == 6 {
            r = CGFloat(( rgb & 0xFF0000 ) >> 16 ) / 255.0
            g = CGFloat(( rgb & 0x00FF00) >> 8 ) / 255.0
            b = CGFloat( rgb & 0x0000FF ) / 255.0
            
        } else if length == 8 {
            r = CGFloat(( rgb & 0xFF000000 ) >> 24 ) / 255.0
            g = CGFloat(( rgb & 0x00FF0000 ) >> 16 ) / 255.0
            b = CGFloat(( rgb & 0x0000FF00 ) >> 8 ) / 255.0
            a = CGFloat( rgb & 0x000000FF ) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
    /// Gets a `String` containing the Hex code of this `Color`.
    ///
    /// - Returns: A Hex code as a `String`
    ///
    /// - Version: Beta 0.2
    ///
    public func toHex() throws -> String {
        
        #if os(macOS)
        let cgColor = NSColor( self ).cgColor
        #elseif os(iOS)
        let cgColor = UIColor( self ).cgColor
        #endif

        guard let components = cgColor.components, components.count >= 3 else {
            throw HydraSwiftExtensionsError.couldntCreateCGColor
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
    /// An `Optional<String>` containing the Hex Code of this `Color`
    public var hexString : String? {
        return try? toHex()
    }
}

