//
//  ResentSearch.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit


/// Represents a Search.
class RecentSearch: NSObject {
    private(set) var searchId: Int
    private(set) var searchName: String
    private(set) var dateTime: Date
    
   
    init(searchId: Int, searchName: String, dateTime: Date) {
        self.searchId      = searchId
        self.searchName    = searchName
        self.dateTime      = dateTime
    }
}

