//
//  EncodingPlusMoreJSON.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation


extension Encodable {
	
	/// Returns An `Optional String` object containing the JSON Encoded version of this object or nil.
    public var jsonString: String? { try? jsonEncodedString() }
	
	/// Returns An `Optional Data` object containing the JSON Encoded version of this object or nil.
    public var jsonData: Data? { try? jsonEncoded() }
    
    /// Creates a `Data` object containing the Encoded JSON data from this object.
    ///
    /// - Throws: Any `Error`s thrown by the JSON Encoding.
    ///
    /// - Returns: The created `Data` object.
    ///
    public func jsonEncoded(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
	
	/// Creates a `String` containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s thrown during the JSON or `String` Encoding.
	///
	/// - Returns: The created `String`
	///
	public func jsonEncodedString() throws -> String {
        String(decoding: try jsonEncoded(), as: UTF8.self)
	}
}
