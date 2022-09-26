//
//  CitySearchRouter.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import UIKit

protocol CitySearchRoutingLogic: AnyObject {
    func routeToMap(item: CityItem)
}

protocol CitySearchDataPassing: AnyObject {
    var dataStore: CitySearchDataStore? { get }
}

final class CitySearchRouter: CitySearchRoutingLogic, CitySearchDataPassing {
    
    weak var viewController: CitySearchViewController?
    var dataStore: CitySearchDataStore?
    
    func routeToMap(item: CityItem) {
        let mapViewController: CityMapViewController = UIApplication.getViewController()
        mapViewController.router?.dataStore?.city = item
        let navigationController = UINavigationController(rootViewController: mapViewController)
        viewController?.present(navigationController, animated: true, completion: nil)
    }
    
}
