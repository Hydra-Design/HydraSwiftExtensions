//
//  HydraDecoding.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation

final public class HydraDecoding {
    
    public init() {}
	
	/// Converts an `Array` of JSON `Strings` to an `Array` of the given objectType.
	///
	/// - Parameters:
	///   - objects: An `Array` of JSON `Strings` to convert to an `Array` of objectType.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of the given objectType.
	///
	static public func convertJSONStringList< objectType : Codable >( _ objects : [ String ] ) throws -> [ objectType ] {
		
		var returnData : [ objectType ] = []
		
		do {
			
			try objects.forEach { item in
				
				// Converts the item from `String` to `Data`
				let objectData = item.data( using: .utf8 ) ?? Data()
				
				// Converts the objectData value into the given objectType
				let convertedData = try JSONDecoder().decode( objectType.self, from: objectData )
				
				returnData.append( convertedData )
			}
			
		} catch ( let error ) {
			throw error
		}
		
		return returnData
	}
	
	/// Converts an `Array` of JSON `Data` objects to an `Array` of the given objectType.
	///
	/// - Parameters:
	///   - objects: An `Array` of JSON `Data` objects to convert to an `Array` of objectType.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of the given objectType.
	///
	static public func convertJSONDataList< objectType : Codable >( _ objects : [ Data ] ) throws -> [ objectType ] {
		
		var returnData : [ objectType ] = []
		
		do {
			
			try objects.forEach { item in
				
				let convertedData = try JSONDecoder().decode( objectType.self, from: item )
				
				returnData.append( convertedData )
			}
			
		} catch ( let error ) {
			throw error
		}
		
		return returnData
	}
	
	/// Converts an `Array` of any `Codable` objects to an `Array` of JSON `Strings`.
	///
	/// - Parameters:
	///   - objects: An `Array` of `Codable` objects to convert to an `Array` of `Strings`.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of JSON `Strings`.
	///
	static public func convertToJSONStringList< objectType : Codable >( _ objects : [ objectType ] ) -> [ String ] {
		
		var returnData : [ String ] = []
		
		objects.forEach { item in
			
			if let encodedData = item.jsonString { returnData.append( encodedData ) }
			
		}
		
		return returnData
	}
	
	/// Converts an `Array` of any `Codable` objects to an `Array` of JSON `Data` objects.
	///
	/// - Parameters:
	///   - objects: An `Array` of `Codable` objects to convert to an `Array` of `Data` objects.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of JSON `Data` objects.
	///
	static public func convertToJSONDataList< objectType : Codable >( _ objects : [ objectType ] ) -> [ Data ] {
		
		var returnData : [ Data ] = []
		
		objects.forEach { item in
			
			if let encodedData = item.jsonData { returnData.append( encodedData ) }
			
		}
		
		return returnData
	}
	
	/// Converts a `NSDictionary` of (`Any?`, `String`) key value pairs, where value is a JSON `String`, to an `Array` of the given objectType.
	///
	/// - Parameters:
	///    - dict: A `NSDictionary` of (`Any?`, `String`) key value pairs, where value is a JSON `String`.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///   An `Array` of the given objectType.
	///
	static public func convertJSONStringDict< objectType : Codable >( _ dict : NSDictionary ) throws -> [ objectType ] {
		
		var returnData : [ objectType ] = []
		
		for ( _, value ) in dict {
			
			do {
				
				if let stringData = value as? String,
				   let convertedData : objectType = try HydraDecoding.convertJSONString( stringData ) {
					returnData.append( convertedData )
				}
				
			} catch ( let error ) { throw error }
		}
		
		return returnData
	}
	
	
	/// Converts a `Data` object into the given `objectType`.
	///
	///  - Parameters:
	///    - object: A `Data` object to convert.
	///
	///  - Version:
	///    1.0
	///
	///  - Returns:
	///    The given `objectType` or `nil`
	///
	static public func convertJSONData< objectType : Codable >( _ object : Data ) throws -> objectType? {
		
		do {
			let data = try JSONDecoder().decode( objectType.self, from: object )
			
			return data
		} catch( let error ) { print( error ) }
		
		return nil
	}
	
	/// Converts a `String` object into the given `objectType`.
	///
	///  - Parameters:
	///    - object: A `String`, containing JSON data, to convert.
	///
	///  - Version:
	///    1.0
	///
	///  - Returns:
	///    The given `objectType` or `nil`
	///
	static public func convertJSONString< objectType : Codable >( _ object : String ) throws -> objectType? {
		
		do {
			let objectData = object.data( using: .utf8 ) ?? Data()
			
			let data = try JSONDecoder().decode( objectType.self, from: objectData )
			
			return data
		} catch( let error ) { print( error ) }
		
		return nil
	}
}
