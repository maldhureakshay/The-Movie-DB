//
//  Result.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

enum Result<T> {
    case Success(T)
    case Error(RestError)
    case JSONParsingFailure()
}

