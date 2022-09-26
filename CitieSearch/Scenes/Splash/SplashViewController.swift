//
//  SplashViewController.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import UIKit
import Extensions

protocol SplashDisplayLogic: AnyObject {
    func displayCities(viewModel: Splash.FetchCities.ViewModel)
    func displayInformation(message: String)
    func displayAlert(message: String)
}

final class SplashViewController: UIViewController, AlertPresentableLogic {
    
    var interactor: SplashBusinessLogic?
    var router: (SplashRoutingLogic & SplashDataPassing)?
    
    @IBOutlet private weak var informationLabel: UILabel?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
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
        let interactor = SplashInteractor(worker: SplashWorker())
        let presenter = SplashPresenter()
        let router = SplashRouter()
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
        fetchCities()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc private func fetchCities() {
        activityIndicator?.startAnimating()
        interactor?.fetchCities(request: .init())
    }
}

extension SplashViewController: SplashDisplayLogic {
    
    func displayCities(viewModel: Splash.FetchCities.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator?.stopAnimating()
            self?.router?.routeToCitySearch(viewModel: viewModel)
        }
    }
    
    func displayInformation(message: String) {
        DispatchQueue.main.async { [weak informationLabel] in
            informationLabel?.text?.append(contentsOf: "\n\(message)")
        }
    }
    
    func displayAlert(message: String) {
        presentAlert(
            "error".localizeIt, message: message, actionTitle: "try_again".localizeIt
        ) { [weak self] in
            self?.fetchCities()
        }
    }
}
