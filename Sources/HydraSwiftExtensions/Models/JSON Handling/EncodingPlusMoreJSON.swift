//
//  EncodingPlusMoreJSON.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation


extension Encodable {
	
	/// Returns An `Optional String` object containing the JSON Encoded version of this object or nil.
	var jsonString : String? {
		
		if let returnData = try? jsonEncodeAsString() { return returnData }
		
		return nil
	}
	
	/// Returns An `Optional Data` object containing the JSON Encoded version of this object or nil.
	var jsonData : Data? {
		
		if let returnData = try? jsonEncodeAsData() { return returnData }
		
		return nil
	}
	
	/// Creates a `Data` object containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s caught during the JSON Encoding.
	///
	/// - Returns: The created `Data` object.
	///
	func jsonEncodeAsData() throws -> Data {
		
		do {
			
			return try JSONEncoder().encode( self )
		}
		catch ( let error ) {
			
			throw error
		}
		
	}
	
	/// Creates a `String` containing the Encoded JSON data from this object.
	///
	/// - Throws: Any `Error`s caught during the JSON or `String` Encoding.
	///
	/// - Returns: The created `String`
	///
	func jsonEncodeAsString() throws -> String {
		
		do {
			let jsonData = try JSONEncoder().encode( self )
			
			if let returnString = String( data: jsonData, encoding: .utf8 ) { return returnString }
			else { throw EncodingErrors.jsonStringEncodingError }
		}
		catch( let error ) {
			throw error
		}
	}
}

enum EncodingErrors : Error {
	
	case jsonStringEncodingError
}
