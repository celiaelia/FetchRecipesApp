//
//  NetworkManagerMock.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/25/25.
//

import XCTest
@testable import FetchRecipesProject

enum NetworkResult {
    case failed
    case empty
    case success
}

class NetworkManagerMock: NetworkManagerProtocol {
    var recipesUrl: URL?
    
    var result: NetworkResult = .success
    
    func fetchAllRecipes() async throws -> [FetchRecipesProject.Recipe] {
        switch result {
        case .failed:
            throw NetworkError.invalidData
        case .empty:
            return []
        case .success:
            return MockData.recipes
        }
    }
    
    func downloadImage(urlString: String) async throws -> UIImage {
        throw NetworkError.invalidUrl
    }
    
    
}
