//
//  ViewController.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    let reuseIdentifier = "SearchTableViewCell"
    var searchController : UISearchController!
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        initialize()
        configUI()
    }
    
    func initialize()  {
        
        let apiClient  = MoviesAPIClient()
        viewModel = SearchViewModel.init(restController: apiClient)
        addNotifications()
        
        self.tblView.estimatedRowHeight = 44.0
        self.tblView.rowHeight = UITableViewAutomaticDimension
        
        //setup search controller
        let recentSearchController : RecentSearchTableViewController = storyboard?.instantiateViewController(withIdentifier: "RecentSearchTableViewController") as! RecentSearchTableViewController
        recentSearchController.delegate = self
        searchController = UISearchController(searchResultsController: recentSearchController)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    
    //Configuring UI
    func configUI() {
        self.title = "The Movie DB"
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    //add observers for data
    func addNotifications() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: NotificationName.loadingError.rawValue), object: nil, queue: nil, using: errorOccurred)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: NotificationName.moviesLoaded.rawValue), object: nil, queue: nil, using: dataLoaded)
    }


    func errorOccurred(notification: Notification) {
        if let error = notification.object as? RestError {
            self.showAlert(title: "Error", text: "\(error.message) - \(error.code)")
        }
    }
    
    func dataLoaded(notification: Notification) {
        //displaying message if no records found
        if viewModel.movies.count <= 0{
            self.showAlert(title: "Sorry", text: "No results found for your search")
        }
        self.tblView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
    @IBAction func searchAction(_ sender: Any) {
        DispatchQueue.main.async {
             self.searchController.isActive = true
        }
    }
    
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCells(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SearchTableViewCell
        if let data = viewModel.getMovie(indexPath.row){
            cell.setupCell(data: data)
        }
        viewModel.currentIndex = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}


extension SearchViewController:  UISearchBarDelegate {
    
    // MARK: - UISearchBarDelegate Delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.searchController.searchResultsController?.view.isHidden = false
        }
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchBar = searchController.searchBar
        viewModel.query = searchBar.text!
        DispatchQueue.main.async {
            self.searchController.searchResultsController?.view.isHidden = true
        }
    }
    
}

extension SearchViewController : RecentSearchControllerDelegate{
    func didSelectSearch(searchName: String) {
        self.searchController.searchBar.text = searchName
        viewModel.query = searchName
        self.searchController.dismiss(animated: true, completion: nil)
    }
}
