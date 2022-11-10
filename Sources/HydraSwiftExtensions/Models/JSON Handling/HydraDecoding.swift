//
//  HydraDecoding.swift
//  Hydra Swift Extensions
//
//  Created by Lukas Simonson on 10/6/21.
//

import Foundation

public enum HydraDecoding {
    	
	/// Converts an `Array` of JSON `Strings` to an `Array` of the given Object.
	///
	/// - Parameters:
	///   - objects: An `Array` of JSON `Strings` to convert to an `Array` of Object.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of the given Object.
	///
	static public func convertJSONStringList< Object : Codable >( _ jsonObjects : [ String ] ) throws -> [ Object ] {
        return try jsonObjects.compactMap { jsonObj in
            try Self.convertJSONString( jsonObj )
        }
	}
	
	/// Converts an `Array` of JSON `Data` objects to an `Array` of the given Object.
	///
	/// - Parameters:
	///   - objects: An `Array` of JSON `Data` objects to convert to an `Array` of Object.
	///
	/// - Version:
	///    1.0
	///
	/// - Returns:
	///    An `Array` of the given Object.
	///
	static public func convertJSONDataList< Object : Codable >( _ jsonObjects : [ Data ] ) throws -> [ Object ] {
        return try jsonObjects.compactMap { jsonObj in
            try Self.convertJSONData( jsonObj )
        }
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
	static public func convertToJSONStringList< Object : Codable >( _ objects : [ Object ] ) -> [ String ] {
        return objects.compactMap { obj in
            obj.jsonString
        }
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
	static public func convertToJSONDataList< Object : Codable >( _ objects : [ Object ] ) -> [ Data ] {
        return objects.compactMap { obj in
            obj.jsonData
        }
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
	static public func convertJSONStringDict< Object : Codable >( _ dict : NSDictionary ) throws -> [ Object ] {
        return try dict.compactMap { ( _, value ) in
            guard let strVal = value as? String else { throw HydraDecodingError.invalidDictionary }
            return try Self.convertJSONString( strVal )
        }
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
	///    The given `objectType`
	///
	static public func convertJSONData< Object : Codable >( _ objectData : Data ) throws -> Object {
        try JSONDecoder().decode( Object.self, from: objectData )
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
	///    The given `objectType`
	///
	static public func convertJSONString< Object : Codable >( _ objectStr : String ) throws -> Object {
        let data = objectStr.data( using: .utf8 ) ?? Data()
        return try JSONDecoder().decode( Object.self, from: data )
	}
    
    /// Takes a Filename and retrieves the `JSON` `Data` within the file. Then returns the given Object.
    ///
    /// - Parameters:
    ///   - filename: The name of the Bundled JSON File.
    ///
    /// - Version:
    ///   1.0
    ///
    /// - Returns:
    ///   The given `Object`
    ///
    static public func loadAndConvertBundledJSONFile< Object : Codable >( filename: String ) throws -> Object {
        
        guard let url = Bundle.main.url( forResource: filename, withExtension: "json" )
        else { throw HydraDecodingError.couldntFindFileNamed( name: filename ) }
        
        let data = try Data(contentsOf: url)
        return try Self.convertJSONData( data )
    }
}

enum HydraDecodingError : Error {
    case invalidDictionary
    case couldntFindFileNamed( name: String )
}
