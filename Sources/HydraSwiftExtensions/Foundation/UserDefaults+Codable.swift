//
//  UserDefaults+Codable.swift
//  HydraSwiftExtensions
//
//  Created by Lukas Simonson on 10/31/24.
//

import Foundation

extension UserDefaults {
    
    /// Encodes the provided value as JSON data and saves it to `UserDefaults` using the provided key.
    public func setEncodable<E: Encodable>(value: E, for key: String, encoder: JSONEncoder = JSONEncoder()) throws {
        try self.setValue(encoder.encode(value), forKey: key)
    }
    
    /// Decodes the value stored in `UserDefaults` at the provided key, from JSON.
    public func decodable<D: Decodable>(for key: String, as type: D.Type = D.self, using decoder: JSONDecoder = JSONDecoder()) throws -> D? {
        if let data = self.data(forKey: key) {
            return try decoder.decode(type, from: data)
        } else {
            return nil
        }
    }
}
