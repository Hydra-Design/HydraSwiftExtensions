//
//  ViewPlusBordered.swift
//  
//
//  Created by Lukas Simonson on 11/14/22.
//

import SwiftUI

@available(macOS 10.15, iOS 13, *)
extension View {
    
    /// Applies a Stroke and Clips this `View` to a `Shape`.
    ///
    /// - Parameters:
    ///   - shape: The shape to clip this `View` into.
    ///   - stroke: The border style you want to apply to this `View`.
    ///   - strokeWidth: The width you want the stroke to be on this `View`.
    ///
    func bordered( in shape: some Shape, stroke: some ShapeStyle, strokeWidth: CGFloat ) -> some View {
        self
            .clipShape(shape)
            .overlay(shape.stroke(stroke, lineWidth: strokeWidth))
    }
}
