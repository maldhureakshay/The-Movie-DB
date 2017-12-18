//
//  Constants.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit


let BASE_IMAGE_URL = "http://image.tmdb.org/t/p/w92/"
let PLACEHOLDER_IMAGE  = "placeholder.png"

enum NotificationName: String {
    case moviesLoaded = "moviesLoaded"
    case loadingError = "loadingError"
}
struct API_URLs {
    static let searchMovie = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838"
}

