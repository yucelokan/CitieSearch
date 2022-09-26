//
//  CityMapRouter.swift
//  CitieSearch
//
//  Created by okan.yucel on 6.03.2022.
//

import Foundation

protocol CityMapRoutingLogic: AnyObject {
    
}

protocol CityMapDataPassing: AnyObject {
    var dataStore: CityMapDataStore? { get }
}

final class CityMapRouter: CityMapRoutingLogic, CityMapDataPassing {
    
    weak var viewController: CityMapViewController?
    var dataStore: CityMapDataStore?
    
}
