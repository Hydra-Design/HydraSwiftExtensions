//
//  HydraHTTP.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 4/28/22.
//

import Foundation

@available(iOS 15.0, macOS 12.0, *)
extension URLSession {
    
    /// Takes a `URL` and retrieves a `Data` object and converts it to the given `Codable` objectType.
    ///
    /// - Parameters:
    ///   - url : The `URL` to retrieve the `Data` from.
    ///
    /// - Throws : A `URLSession` or `JSONDecoder` `Error`
    ///
    /// - Returns : The given `Codable` objectType created from the given `URL`s `Data`.
    ///
    func object<Object: Codable>(from url: URL) async throws -> Object {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try HydraDecoding.convertJSONData(data)
    }
    
    /// Takes a `URLRequest` and retrieves a `Data` object and converts it to the given `Codable` objectType.
    ///
    /// - Parameters:
    ///   - request : The `URLRequest` to use to retrieve `Data` from.
    ///
    /// - Throws : A `URLSession` or `JSONDecoder` `Error`
    ///
    /// - Returns : The given `Codable` objectType created from the given `URLRequest`s `Data`.
    ///
    func object<Object: Codable>(for request: URLRequest) async throws -> Object {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try HydraDecoding.convertJSONData(data)
    }
}

@available(iOS 15.0, macOS 12.0, *)
@available(*, deprecated, message: "Use URLSession.object instead.")
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
    @available(*, deprecated, message: "Use URLSession.object instead.")
    public static func getObjectFromURL< Object: Codable >( _ url: URL ) async throws -> Object {
        let ( data, _ ) = try await URLSession.shared.data( from: url )
        return try HydraDecoding.convertJSONData( data )
    }
}
