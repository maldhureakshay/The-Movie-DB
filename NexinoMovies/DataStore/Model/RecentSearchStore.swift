//
//  SearchStore.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit


class RecentSearchStore: NSObject {
    /// Collection of author names.
    var searchNames: Array<String> {
        get {
            return self.recentSearchCache.searchNames
        }
    }
    
    
    
    /// Factory of a data access objects.
    private let daoFactory: DAOFactory
    
    /// Manager for the book data.
    private var recentSearchCache: RecentSearchCache!
    
    /// Initialize the instance.
    ///
    /// - Parameter daoFactory: Factory of a data access objects.
    init(daoFactory: DAOFactory) {
        self.daoFactory = daoFactory
        super.init()
        
        if let dao = self.daoFactory.recentSearchDAO() {
            dao.create()
            self.recentSearchCache = RecentSearchCache(searchs: dao.read())
        }
    }
    
  
    func add(recentSearch: RecentSearch,wasRemoved : Bool = false) -> Bool {
        if let dao = self.daoFactory.recentSearchDAO(), let newSearch = dao.add(searchName: recentSearch.searchName ,date: recentSearch.dateTime) {
            return self.recentSearchCache.add(search: newSearch, wasRemoved: wasRemoved)
        }
        return false
    }
    
    
    func checkIfSearchExists(searchName: String) -> Array<RecentSearch>? {
     if let dao = self.daoFactory.recentSearchDAO() {
            return dao.checkSearchIfExists(searchName:searchName)
        }
        return nil
    }
    
    
    func remove(search: RecentSearch) -> Bool {
        if let dao = self.daoFactory.recentSearchDAO(), dao.remove(searchId: search.searchId) {
            return self.recentSearchCache.remove(search: search)
        }
        
        return false
    }
  
  
 
   
}

