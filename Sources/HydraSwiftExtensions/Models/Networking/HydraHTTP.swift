//
//  File.swift
//  
//
//  Created by Lukas Simonson on 4/28/22.
//

import Foundation

final public struct HydraHTTP {
    
    /// Takes a `URL` and retrieves a `Data` object and converts it to the given `Codable` objectType.
    ///
    /// - Parameters:
    ///   - url : The `URL` to retrieve the `Data` from.
    ///
    /// - Throws : A `URLSession` or `JSONDecoder` `Error`
    ///
    /// - Returns : The given `Codable` objectType created from the given `URL`s `Data`.
    ///
    static func getObjectFromUrl< objectType : Codable >( _ url : URL ) async throws -> objectType {

        do {
            let ( data, _ ) = try await URLSession.shared.data( from: url )
            return try HydraDecoding.convertJSONData( data )
            
        } catch ( let error ) { throw error }
    }
}
