//
//  SplashPresenter.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import Swiftrie
import Extensions
import API

protocol SplashPresentationLogic: AnyObject {
    func presentCities(response: Splash.FetchCities.Response)
    func presentAlert(message: String)
    func presentInformation(message: String)
}

final class SplashPresenter: SplashPresentationLogic {
    
    weak var viewController: SplashDisplayLogic?
    
    func presentCities(response: Splash.FetchCities.Response) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            self?.presentInformation(
                message: "data_structure_preparing".localizeIt
            )
            
            Logger.info("ordering_cities_started".localizeIt)
            let orderedCities = response.cities.sorted(
                by: {$0.name?.lowercased() ?? "" < $1.name?.lowercased() ?? ""}
            )
            Logger.info("ordering_cities_completed".localizeIt)
            
            Logger.info("data_structure_creating_started".localizeIt)
            let trie = Swiftrie(swiftriables: orderedCities)
            Logger.info("data_structure_creating_completed".localizeIt)
            
            self?.presentInformation(message: "data_structure_ready".localizeIt)
            
            self?.viewController?.displayCities(viewModel: .init(trie: trie, cities: orderedCities))
        }
    }
    
    func presentAlert(message: String) {
        viewController?.displayAlert(message: message)
    }
    
    func presentInformation(message: String) {
        viewController?.displayInformation(message: "\n\(message)")
    }
}
