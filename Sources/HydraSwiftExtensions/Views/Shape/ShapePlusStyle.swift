//
//  File.swift
//  
//
//  Created by Lukas Simonson on 11/1/22.
//

import SwiftUI

@available(macOS 10.15, *)
@available(iOS 13.0, *)
public extension Shape {
    
    /// Styles this `Shape` with the given stroke and fill.
    ///
    /// - Parameters:
    ///   - stroke: A `ShapeStyle` conforming object to use as the Stroke / Border of this Shape.
    ///   - strokeWidth: A `CGFloat` that controls the thickness of this Shapes Stroke / Border.
    ///   - fill: A `ShapeStyle` conforming object to use as the fill of this Shape.
    ///
    /// - Version:
    ///   1.0
    ///
    /// - Returns:
    ///   `some View`
    func style (
        stroke: some ShapeStyle,
        strokeWidth: CGFloat,
        fill fillContent: some ShapeStyle
    ) -> some View {
        self
            .stroke(stroke, lineWidth: strokeWidth)
            .background(fill(fillContent))
    }
}
