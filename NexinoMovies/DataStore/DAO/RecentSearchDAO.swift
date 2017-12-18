//
//  RecentSearchDAO.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
import FMDB

/// Manage for the recent search data table.
class RecentSearchDAO: NSObject {
    //create table.
    private static let SQLCreate = "" +
        "CREATE TABLE IF NOT EXISTS recentsearch (" +
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "search_name TEXT, " +
        "date INTEGER" +
    ");"
    
    //select row.
    private static let SQLSelect = "" +
        "SELECT " +
        "id, search_name, date " +
        "FROM " +
        "recentsearch " +
        "ORDER BY " +
        "id DESC LIMIT 10;"

    
    //select row.
    private static let SQLSelectForSearch = "" +
        "SELECT " +
        "id, search_name, date " +
        "FROM " +
        "recentsearch " +
        "WHERE " +
    "search_name = ?;"
    
    //insert row.
    private static let SQLInsert = "" +
        "INSERT INTO " +
        "recentsearch (search_name, date) " +
        "VALUES " +
    "(?, ?);"
    
 
    //update row.
    private static let SQLUpdate = "" +
        "UPDATE " +
        "recentsearch " +
        "SET " +
        "search_name = ?, date = ?" +
        "WHERE " +
    "id = ?;"
    
    //delete row.
    private static let SQLDelete = "DELETE FROM recentsearch WHERE id = ?;"

    
    
    private let db: FMDatabase
    
    init(db: FMDatabase) {
        self.db = db
        super.init()
    }
    
    deinit {
        self.db.close()
    }
    
    /// Create the table.
    func create() {
        self.db.executeUpdate(RecentSearchDAO.SQLCreate, withArgumentsIn: [])
    }
    
    //insert
    func add(searchName: String,date: Date) -> RecentSearch? {
        var recentSearch: RecentSearch? = nil
        if self.db.executeUpdate(RecentSearchDAO.SQLInsert, withArgumentsIn: [searchName, date]) {
            let searchId = db.lastInsertRowId
            recentSearch = RecentSearch.init(searchId: Int(searchId), searchName: searchName, dateTime: date)
            
        }
        
        return recentSearch
    }
    
    //fetch
    func read() -> Array<RecentSearch> {
        var recentSearchs = Array<RecentSearch>()
        if let results = self.db.executeQuery(RecentSearchDAO.SQLSelect, withArgumentsIn: []) {
            while results.next() {
                let search = RecentSearch(searchId: results.long(forColumnIndex: 0), searchName: results.string(forColumnIndex: 1)!, dateTime: results.date(forColumnIndex: 2)!)
                recentSearchs.append(search)
            }
        }
        
        return recentSearchs
    }
    
    //update
    func update(recentSearch: RecentSearch) -> Bool {
        return db.executeUpdate(RecentSearchDAO.SQLUpdate,
                                withArgumentsIn: [
                                    recentSearch.searchName,
                                    recentSearch.dateTime,
                                    recentSearch.searchId])
    }
    
    //remove
    func remove(searchId: Int) -> Bool {
        return self.db.executeUpdate(RecentSearchDAO.SQLDelete, withArgumentsIn: [searchId])
    }
    
    //check search exists
    func checkSearchIfExists(searchName : String) -> Array<RecentSearch> {
        var recentSearchs = Array<RecentSearch>()
        if let results = self.db.executeQuery(RecentSearchDAO.SQLSelectForSearch, withArgumentsIn: [searchName]) {
            
            while results.next() {
                let search = RecentSearch(searchId: results.long(forColumnIndex: 0), searchName: results.string(forColumnIndex: 1)!, dateTime: results.date(forColumnIndex: 2)!)
                recentSearchs.append(search)
            }
        }
        
        return recentSearchs
    }
    
}
