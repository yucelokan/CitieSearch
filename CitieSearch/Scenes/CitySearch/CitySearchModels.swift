//
//  CitySearchModels.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import API
import Swiftrie

extension City: CityItem {
    var title: String {
        return "\(name ?? ""), \(country ?? "")"
    }
    
    var subtitle: String {
        let latitudeMessage =  "latitude".localizeIt + ": \(coordinate?.lat ?? 0)"
        let longitudeMessage =  "longitude".localizeIt + ": \(coordinate?.lon ?? 0)"
        return latitudeMessage + "\n" + longitudeMessage
    }
    
    var latitude: Double {
        return coordinate?.lat ?? 0
    }
    
    var longitude: Double {
        return coordinate?.lon ?? 0
    }
}

// swiftlint:disable nesting
enum CitySearch {
    
    enum Search {
        struct Request {
            var text: String
        }
        
        struct Response {
            var cities: [City]
        }
        
        struct ViewModel {
            var cities: [CityItem]
        }
        
    }
    
    enum SearchThrottle {
        case calculate(count: Int?)
        
        var second: Double {
            switch self {
            case .calculate(let count):
                guard let count = count, count != 0 else {
                    return 0
                }
                return 0
                // return 0.25 / (Double(count)*2.5)
                // throttle has disabled
            }
        }
    }
    
}
// swiftlint:enable nesting
