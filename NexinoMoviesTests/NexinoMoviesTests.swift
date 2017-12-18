//
//  NexinoMoviesTests.swift
//  NexinoMoviesTests
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//


import XCTest
@testable import NexinoMovies

class NexinoMoviesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func fetchMoviesTest() {
        
        let expect = expectation(description: "fetch the list of movies matching the user search string.")
        
        //test with mock data
        let queryStr = "batman"
        let pageNo = 1
        
        let apiClient = MoviesAPIClient()
        apiClient.fetchMovies(for: queryStr,page: pageNo) { (result) in
            switch result {
            case .Success(let response) :
                //expectation is fullfilled if we get a list of movies
                XCTAssert(response.movies!.count > 0)
                expect.fulfill()
                break
            case .Error(let error) :
                //Test failed.
                XCTFail("Test Failed : \(error.message)")
                break
            default:
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: { _ in
            XCTFail("Timeout")
        })
    }
    
}
