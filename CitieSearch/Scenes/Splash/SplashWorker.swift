//
//  SplashWorker.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import Foundation
import API

protocol SplashWorkingLogic: AnyObject {
    func getCities(request: City.Request, completion: @escaping (Result<[City], Error>) -> Void)
}

final class SplashWorker: SplashWorkingLogic {
    
    func getCities(request: City.Request, completion: @escaping (Result<[City], Error>) -> Void) {
        Stubber.getDataFromLocal(fileName: "cities", completion: completion)
    }
    
}
