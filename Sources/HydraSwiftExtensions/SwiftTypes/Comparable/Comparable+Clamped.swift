//
//  Comparable+Clamped.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

extension Comparable {
    func clamped(_ between: ClosedRange<Self>) -> Self {
        return max(between.lowerBound, min(self, between.upperBound))
    }
}
