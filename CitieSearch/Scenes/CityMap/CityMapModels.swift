//
//  CityMapModels.swift
//  CitieSearch
//
//  Created by okan.yucel on 6.03.2022.
//

import Foundation
import MapKit

// swiftlint:disable nesting
enum CityMap {
    
    enum FetchCity {
        
        struct Request {
            
        }
        
        struct Response {
            let city: CityItem
        }
        
        struct ViewModel {
            let annotation: MKPointAnnotation
            let region: MKCoordinateRegion
            let title: String
        }
        
    }
    
}
// swiftlint:enable nesting
