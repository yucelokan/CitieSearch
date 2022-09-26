//
//  CityMapPresenter.swift
//  CitieSearch
//
//  Created by okan.yucel on 6.03.2022.
//

import Foundation
import MapKit

protocol CityMapPresentationLogic: AnyObject {
    func presentCity(response: CityMap.FetchCity.Response)
    func presentAlert(message: String)
}

final class CityMapPresenter: CityMapPresentationLogic {
    
    weak var viewController: CityMapDisplayLogic?
    
    func presentCity(response: CityMap.FetchCity.Response) {
        
        let location = CLLocationCoordinate2D(
            latitude: response.city.latitude, longitude: response.city.longitude
        )
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: location, span: span)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = response.city.title
        
        viewController?.displayCity(
            viewModel: .init(annotation: annotation, region: region, title: response.city.title)
        )
    }
    
    func presentAlert(message: String) {
        viewController?.displayAlert(message: message)
    }
    
}
