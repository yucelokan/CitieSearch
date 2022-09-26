//
//  SplashInteractor.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation

protocol SplashBusinessLogic: AnyObject {
    func fetchCities(request: Splash.FetchCities.Request)
}

protocol SplashDataStore: AnyObject {
    
}

final class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    
    var presenter: SplashPresentationLogic?
    var worker: SplashWorkingLogic?
    
    init(worker: SplashWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCities(request: Splash.FetchCities.Request) {
        presenter?.presentInformation(message: "cities_exporting".localizeIt)
        worker?.getCities(request: .init(), completion: { [weak presenter] result in
            switch result {
            case .success(let response):
                presenter?.presentInformation(message: "cities_exporting_completed".localizeIt)
                presenter?.presentCities(response: .init(cities: response))
            case .failure(let error):
                presenter?.presentAlert(message: error.localizedDescription)
            }
        })
    }
}
