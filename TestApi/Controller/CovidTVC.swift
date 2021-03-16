//
//  CovidTVC.swift
//  TestApi
//
//  Created by Евгений on 13.03.2021.
//

import UIKit

class CovidTVC: UITableViewController {
    
    private let url = "https://api.apify.com/v2/key-value-stores/1brJ0NLbQaJKPTWMO/records/LATEST?disableRedirect=true"
    var covidData : Covid19DataRussia?
    var searchController: UISearchController!
    var tap = false
//    var filteredCommentsResult: [InfectedByRegion] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.fetchCurrentCovidDataForRussia(url: url) { (covidData) in
            self.covidData = covidData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//        searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.delegate = self
//        searchController.searchBar.backgroundColor = .white
//        searchController.searchBar.barTintColor = .white
//        searchController.searchBar.placeholder = "Фильтр по комментарию"
//        searchController.searchBar.tintColor = .black
//        tableView.tableHeaderView = searchController.searchBar
    }
    

    
    
//    func filterCommentsFor( searchText text: String){
//        filteredCommentsResult = covidData!.infectedByRegion.filter({ (InfectedByRegion) -> Bool in
//        return (InfectedByRegion.region.lowercased().contains(text.lowercased()))})
//        }
    
    
//     func filteredNamesDisplay(indexPath: IndexPath) -> InfectedByRegion {
//        let region: InfectedByRegion
//        if searchController.isActive && searchController.searchBar.text != "" {
//            region = filteredCommentsResult[indexPath.row]
//        } else {
//            region = covidData!.infectedByRegion[indexPath.row]
//        }
//        return region
//    }
    }
