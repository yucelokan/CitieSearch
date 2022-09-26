//
//  CitySearchPresenter.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

protocol CitySearchPresentationLogic: AnyObject {
    func presentCities(response: CitySearch.Search.Response)
}

final class CitySearchPresenter: CitySearchPresentationLogic {
    
    weak var viewController: CitySearchDisplayLogic?
    
    func presentCities(response: CitySearch.Search.Response) {
        viewController?.displayCities(viewModel: .init(cities: response.cities))
    }
}
