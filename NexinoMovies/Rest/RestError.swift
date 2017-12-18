//
//  ServiceError.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

class RestError: Error {
    public var code: Int = -1
    public var message: String = "Unknown error occurred."
    
    public init(code: Int, message: String)
    {
        self.code = code
        self.message = message
    }
    
}
