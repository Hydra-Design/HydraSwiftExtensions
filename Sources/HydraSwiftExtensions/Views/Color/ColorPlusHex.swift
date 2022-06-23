//
//  File.swift
//  
//
//  Created by Lukas Simonson on 4/27/22.
//

import Foundation
import SwiftUI
//import UIKitf

@available(iOS 13.0, *)
@available(macOS 10.15, *)
extension Color {

	/// Gives a SwiftUI.Color object using a Hex Color code
	///
	/// - Parameters:
	///    - hex: The hex color code string to parse into a Color
	///
	/// - Version: Beta 0.1
    /// 
	public init( hex: String ) {
		
		let scanner = Scanner(string: hex)
		scanner.currentIndex = .init(utf16Offset : 0, in: hex)
		var rgbValue: UInt64 = 0
		scanner.scanHexInt64(&rgbValue)
		
		let red = ( rgbValue & 0xff0000 ) >> 16
		let green = ( rgbValue & 0xff00 ) >> 8
		let blue = ( rgbValue & 0xff )
		
		self = Color( .sRGB,
					  red: Double( red ) / 0xff,
					  green: Double( green ) / 0xff,
					  blue: Double( blue ) / 0xff,
					  opacity: 1
		)
	}
}
