//
//  SearchViewModel.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class SearchViewModel {

    let rest: RestProtocol!
    var currentPage = 1
    var totalPages = 1
    var movies: [Movie] = []
    
    var query : String = "" {
         didSet {
            currentPage = 1
            searchMovies(page: currentPage)
        }
    }
    
    var currentIndex : Int = 0{
        didSet {
            checkLoadMore()
        }
    }
    
    init(restController: RestProtocol) {
        self.rest = restController
        
        searchMovies(page: 1)
    }
    
    func searchMovies(page : Int) {
        
        self.rest.fetchMovies(for: query,page: page) { (result) in
            switch result {
            case .Success(let response) :
                if let movies = response.movies {
                    if self.currentPage > 1 {
                        self.movies.append(contentsOf: movies)
                    }else{
                        self.movies = movies
                        self.saveSearch()
                        
                    }
                   self.currentPage = response.page as! Int
                   self.totalPages = response.total_pages as! Int
                   NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: NotificationName.moviesLoaded.rawValue), object: nil)
                }
                
            case .Error(let error) :
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationName.loadingError.rawValue), object: error)
                 break
                default:
                    break
            }
        }
    }

    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getNumberOfCells(_ section: Int) -> Int {
        return self.movies.count
    }
    
    func getMovie(_ index: Int) -> Movie? {
        if index < movies.count {
            return self.movies[index]
        }
        return nil
    }
    
    func checkLoadMore(){
        if currentIndex > (movies.count - 2) && currentPage != totalPages{
            let nextPage = currentPage + 1
            searchMovies(page: nextPage)
        }
    }
    
    func saveSearch()  {
        if self.movies.count > 0 {
            
            if let recentSearch =  self.searchStore().checkIfSearchExists(searchName: query), recentSearch.count > 0 {
                for i in 0..<recentSearch.count{

                    _ = self.searchStore().remove(search: recentSearch[i])
                }
                let search = RecentSearch(searchId: 0, searchName: query, dateTime: Date())
                if self.searchStore().add(recentSearch: search, wasRemoved: true) {
                    print("Search Saved")
                }
                
            }else{
                let search = RecentSearch(searchId: 0, searchName: query, dateTime: Date())
                if self.searchStore().add(recentSearch: search,wasRemoved: true) {
                    print("Search Saved")
                }
            }
        }
    }
    
    func searchStore() -> RecentSearchStore {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appStore.searchStore
    }
}
