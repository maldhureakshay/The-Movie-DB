//
//  RestProtocol.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation

protocol RestProtocol {
     func fetchMovies(for query : String?,page : Int?,completionHandler: @escaping (Result<MovieMapper>) -> Void)
}
