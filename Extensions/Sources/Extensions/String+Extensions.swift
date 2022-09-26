//
//  String+Extensions.swift
//  
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

public extension String {
    func toObject<T: Decodable>(type: T.Type) -> T? {
        return try? JSONDecoder().decode(type, from: Data(self.utf8))
    }
}
