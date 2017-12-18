//
//  MovieMapper.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieMapper: Mappable{
    var page : Any?
    var total_results : Any?
    var total_pages : Any?
    var movies : [Movie]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        page            <- map["page"]
        total_results   <- map["total_results"]
        total_pages     <- map["total_pages"]
        movies          <- map["results"]
    }
    
}


