//
//  HydraHTTP.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 4/28/22.
//

import Foundation

@available(iOS 15.0, macOS 12.0, *)
public enum HydraHTTP {
    
    /// Takes a `URL` and retrieves a `Data` object and converts it to the given `Codable` objectType.
    ///
    /// - Parameters:
    ///   - url : The `URL` to retrieve the `Data` from.
    ///
    /// - Throws : A `URLSession` or `JSONDecoder` `Error`
    ///
    /// - Returns : The given `Codable` objectType created from the given `URL`s `Data`.
    ///
    public static func getObjectFromURL< Object: Codable >( _ url: URL ) async throws -> Object {
        let ( data, _ ) = try await URLSession.shared.data( from: url )
        return try HydraDecoding.convertJSONData( data )
    }
}
