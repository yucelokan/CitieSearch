//
//  CityMapInteractor.swift
//  CitieSearch
//
//  Created by okan.yucel on 6.03.2022.
//

import Foundation

protocol CityMapBusinessLogic: AnyObject {
    func fetchCity(request: CityMap.FetchCity.Request)
}

protocol CityMapDataStore: AnyObject {
    var city: CityItem? { get set }
}

final class CityMapInteractor: CityMapBusinessLogic, CityMapDataStore {
    
    var presenter: CityMapPresentationLogic?
    var worker: CityMapWorkingLogic?
    
    var city: CityItem?
    
    init(worker: CityMapWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCity(request: CityMap.FetchCity.Request) {
        guard let city = city else {
            presenter?.presentAlert(message: "an_error_occured".localizeIt)
            return
        }
        presenter?.presentCity(response: .init(city: city))
    }
}
