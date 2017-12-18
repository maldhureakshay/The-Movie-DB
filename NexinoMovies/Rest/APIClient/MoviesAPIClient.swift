//
//  MoviesAPIClient.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireDomain

class MoviesAPIClient: RestProtocol {

    func fetchMovies(for query : String?, page : Int?, completionHandler: @escaping (Result<MovieMapper>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var url = API_URLs.searchMovie
        if let query = query{
            url =  url+"&query=\(query)"
        }
        if let page = page{
            url =  url+"&page=\(page)"
        }
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        AlamofireDomain.request(url, method: .post).responseJSON(completionHandler: {response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch response.result {
            case .success(let data):
                
                if let response = data as? [String : Any]{
                    if let movieMapper = MovieMapper(JSON : response){
                        completionHandler(Result.Success(movieMapper))
                    }
                }
                else{
                    completionHandler(Result.JSONParsingFailure())
                }
            case .failure(let error):
                
                let error = RestError(code: 601, message: error.localizedDescription)
                completionHandler(Result.Error(error))
            }
        })
    }
    
}
