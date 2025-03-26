//
//  NetworkManagerTests.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/25/25.
//

import XCTest
@testable import FetchRecipesProject

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUpWithError() throws {
        networkManager = NetworkManager()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testAllRecipes() async throws {
        let response = try await networkManager.fetchAllRecipes()
        
        XCTAssertGreaterThan(response.count, 0)
    }
    
    func testEmptyRecipes() async throws {
        let emptyDataUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        networkManager.recipesUrl = URL(string: emptyDataUrlString)
    
        let response = try await networkManager.fetchAllRecipes()
        
        XCTAssertEqual(response.count, 0)
    }
    
    func testMalformedData() async throws {
        let malformedDataUrlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        networkManager.recipesUrl = URL(string: malformedDataUrlString)
    
        do {
            _ = try await networkManager.fetchAllRecipes()
        }
        catch(let error as NetworkError) {
            XCTAssertEqual(error, NetworkError.invalidData)
        }
    }
    
    func testInvalidUrl() async throws {
        let invalidUrlString = "invalid url"
        networkManager.recipesUrl = URL(string: invalidUrlString)
        
        do {
            _ = try await networkManager.fetchAllRecipes()
        }
        catch(let error as NetworkError) {
            XCTAssertEqual(error, NetworkError.invalidUrl)
        }
    }
    
}
