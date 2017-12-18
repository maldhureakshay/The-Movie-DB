//
//  DAOFactory.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
import FMDB

class DAOFactory: NSObject {
    /// Path of the database file.
    private let filePath: String
    
    /// Initialize the instance.
    override init() {
        self.filePath = DAOFactory.databaseFilePath()
        super.init()
        
        print(self.filePath)
    }
    
     init(filePath: String) {
        self.filePath = filePath
        super.init()
    }
    
    func recentSearchDAO() -> RecentSearchDAO? {
        if let db = self.connect() {
            return RecentSearchDAO(db: db)
        }
        
        return nil
    }
    
    /// Connect to the database.
    ///
    /// - Returns: Connection instance if successful, nil otherwise.
    private func connect() -> FMDatabase? {
        let db = FMDatabase(path: self.filePath)
        return (db.open()) ? db : nil
    }

    
    /// Get the path of database file.
    ///
    /// - Returns: Path of the database file.
    private static func databaseFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dir   = paths[0] as NSString
        return dir.appendingPathComponent("Nexino.db")
    }
}

