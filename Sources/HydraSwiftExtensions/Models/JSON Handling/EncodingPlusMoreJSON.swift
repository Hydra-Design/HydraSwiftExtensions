//
//  EncodingPlusMoreJSON.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation


extension Encodable {
	
	/// Returns An `Optional String` object containing the JSON Encoded version of this object or nil.
    public var jsonString : String? { try? jsonEncodeAsString() }
	
	/// Returns An `Optional Data` object containing the JSON Encoded version of this object or nil.
    public var jsonData : Data? { try? jsonEncodeAsData() }

	/// Creates a `Data` object containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s caught during the JSON Encoding.
	///
	/// - Returns: The created `Data` object.
	///
    public func jsonEncodeAsData() throws -> Data { try JSONEncoder().encode( self ) }
	
	/// Creates a `String` containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s caught during the JSON or `String` Encoding.
	///
	/// - Returns: The created `String`
	///
	public func jsonEncodeAsString() throws -> String {
        let data = try jsonEncodeAsData()
        if let finalVal = String(data: data, encoding: .utf8) { return finalVal }
        throw HydraEndcodingError.unableToConvertDataToString
	}
}

enum HydraEndcodingError: Error {
    case unableToConvertDataToString
}
