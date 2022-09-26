//
//  SplashModels.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import API
import Swiftrie
import Extensions

extension City: Swiftriable {
    public var prefixableText: String {
        guard let name = name else { return "" }
        return "\(name), \(country ?? "")"
    }
}

// swiftlint:disable nesting
enum Splash {
    
    enum FetchCities {
        
        struct Request {
            
        }
        
        struct Response {
            let cities: [City]
        }
        
        struct ViewModel {
            let trie: Swiftrie
            let cities: [City]
        }
        
    }
    
}
// swiftlint:enable nesting
