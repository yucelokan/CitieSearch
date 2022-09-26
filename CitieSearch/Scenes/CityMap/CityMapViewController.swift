//
//  CityMapViewController.swift
//  CitieSearch
//
//  Created by okan.yucel on 6.03.2022.
//

import MapKit
import Extensions

protocol CityMapDisplayLogic: AnyObject {
    func displayCity(viewModel: CityMap.FetchCity.ViewModel)
    func displayAlert(message: String)
}

final class CityMapViewController: UIViewController, BarButtonConfigurable, AlertPresentableLogic {
    
    var interactor: CityMapBusinessLogic?
    var router: (CityMapRoutingLogic & CityMapDataPassing)?
    
    @IBOutlet private weak var mapView: MKMapView?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = CityMapInteractor(worker: CityMapWorker())
        let presenter = CityMapPresenter()
        let router = CityMapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        interactor?.fetchCity(request: .init())
    }
    
    private func setupUI() {
        addBarButtonItem(ofType: .dismiss(.right))
    }
}

extension CityMapViewController: CityMapDisplayLogic {
    func displayCity(viewModel: CityMap.FetchCity.ViewModel) {
        title = viewModel.title
        mapView?.setRegion(viewModel.region, animated: true)
        mapView?.addAnnotation(viewModel.annotation)
    }
    
    func displayAlert(message: String) {
        presentAlert(
            "error".localizeIt, message: message, actionTitle: "ok".localizeIt
        ) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
