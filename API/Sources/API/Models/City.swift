//
//  City.swift
//  
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

// MARK: - City 
public struct City: Codable {
    public struct Request: Encodable {
        public init() {
            
        }
    }
    
    public let country, name: String?
    public let id: Int?
    public let coordinate: Coordinate?

    enum CodingKeys: String, CodingKey {
        case country, name
        case id = "_id"
        case coordinate = "coord"
    }
}

// MARK: - Coord
public struct Coordinate: Codable {
    public let lon, lat: Double?
}
