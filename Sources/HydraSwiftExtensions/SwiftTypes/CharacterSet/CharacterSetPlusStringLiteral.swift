//
//  CharacterSetPlusStringLiteral.swift
//  
//
//  Created by Lukas Simonson on 3/2/23.
//

import Foundation

extension CharacterSet: @retroactive ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .init(charactersIn: value)
    }
}
