//
//  CitySearchViewController.swift
//  CitieSearch
//
//  Created by okan.yucel on 5.03.2022.
//

import UIKit
import Extensions

protocol CitySearchDisplayLogic: AnyObject {
    func displayCities(viewModel: CitySearch.Search.ViewModel)
}

final class CitySearchViewController: UIViewController {
    
    var interactor: CitySearchBusinessLogic?
    var router: (CitySearchRoutingLogic & CitySearchDataPassing)?
    
    @IBOutlet private weak var tableView: UITableView?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: CitySearch.Search.ViewModel = .init(cities: [])
    
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
        let interactor = CitySearchInteractor(worker: CitySearchWorker())
        let presenter = CitySearchPresenter()
        let router = CitySearchRouter()
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
        interactor?.fetchCities(request: .init(text: ""))
    }
    
    private func setupUI() {
        navigationItem.hidesBackButton = true
        definesPresentationContext = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "type_here".localizeIt
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        
        tableView?.registerNib(CityCell.self, bundle: .main)
    }
    
    private func updateTitle() {
        let cityCount = viewModel.cities.count
        DispatchQueue.main.async { [weak self] in
            self?.title = "search_cities_in".localizeIt.replacingOccurrences(
                of: "{city_count}", with: "\(cityCount)"
            )
        }
    }
}

extension CitySearchViewController: CitySearchDisplayLogic {
    func displayCities(viewModel: CitySearch.Search.ViewModel) {
        self.viewModel = viewModel
        tableView?.reload(animation: false)
        updateTitle()
    }
}

extension CitySearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.cities[indexPath.row]
        router?.routeToMap(item: item)
    }
}

extension CitySearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.cities.count > indexPath.row else { return UITableViewCell() }
        let cell = tableView.dequeueCell(type: CityCell.self, indexPath: indexPath)
        let item = viewModel.cities[indexPath.row]
        cell.configureCell(item)
        return cell
    }
}

extension CitySearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        interactor?.fetchCities(
            request: .init(text: searchController.searchBar.text ?? "")
        )
    }
}
