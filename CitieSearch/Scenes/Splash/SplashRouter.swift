//
//  SplashRouter.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import UIKit

protocol SplashRoutingLogic: AnyObject {
    func routeToCitySearch(viewModel: Splash.FetchCities.ViewModel)
}

protocol SplashDataPassing: AnyObject {
    var dataStore: SplashDataStore? { get }
}

final class SplashRouter: SplashRoutingLogic, SplashDataPassing {
    
    weak var viewController: SplashViewController?
    var dataStore: SplashDataStore?
    
    func routeToCitySearch(viewModel: Splash.FetchCities.ViewModel) {
        let searchViewController: CitySearchViewController = UIApplication.getViewController()
        searchViewController.router?.dataStore?.trie = viewModel.trie
        searchViewController.router?.dataStore?.cities = viewModel.cities
        viewController?.navigationController?.pushViewController(searchViewController, animated: false)
    }
    
}
