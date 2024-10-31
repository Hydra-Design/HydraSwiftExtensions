//
//  OptionallyEquals.swift
//  
//
//  Created by Lukas Simonson on 5/22/23.
//

infix operator ?=: AssignmentPrecedence

/// Assigns the lhs value to the rhs value when the rhs value is not nil.
public func ?=<T>(_ lhs: inout T, rhs: T?) {
    if let rhs { lhs = rhs }
}
