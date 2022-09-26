//
//  CitySearchInteractor.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import Swiftrie
import API

protocol CitySearchBusinessLogic: AnyObject {
    func fetchCities(request: CitySearch.Search.Request)
}

protocol CitySearchDataStore: AnyObject {
    var trie: Swiftrie { get set }
    var cities: [City] { get set }
}

final class CitySearchInteractor: CitySearchBusinessLogic, CitySearchDataStore {
    
    var presenter: CitySearchPresentationLogic?
    var worker: CitySearchWorkingLogic?
    
    var trie: Swiftrie = Swiftrie(swiftriables: [])
    var cities: [City] = []
    
    init(worker: CitySearchWorkingLogic) {
        self.worker = worker
    }
    
    func fetchCities(request: CitySearch.Search.Request) {
        
        guard !request.text.isEmpty else {
            trie.cancelSearch()
            presenter?.presentCities(response: .init(cities: cities))
            return
        }
        
        let throttle = CitySearch.SearchThrottle.calculate(
            count: request.text.count
        ).second.rounded(toPlaces: 2)
        
        let throttleMessage = "throttle_for_searching".localizeIt.replacingOccurrences(
            of: "{throttle}", with: "\(throttle)"
        )
        Logger.info(throttleMessage)
        
        let searchStartDate = Date()
        
        trie.findItems(
            prefix: request.text,
            throttle: throttle,
            type: City.self,
            completion: { [weak self] results in
                let seconds = Date().timeIntervalSince(searchStartDate).rounded(toPlaces: 4)
                let searchMessage = "search_response_message".localizeIt.replacingOccurrences(
                    of: "{city_count}", with: "\(results.count)"
                ).replacingOccurrences(
                    of: "{seconds}", with: "\(seconds)"
                ).replacingOccurrences(of: "{text}", with: request.text)
                
                Logger.info(searchMessage)
                self?.presenter?.presentCities(response: .init(cities: results))
            }
        )
    }
    
}
