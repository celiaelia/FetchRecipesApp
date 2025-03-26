//
//  NetworkManager.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/22/25.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    var recipesUrl: URL? { get set}
    
    func fetchAllRecipes() async throws -> [Recipe]
    
    func downloadImage(urlString: String) async throws -> UIImage
}

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

class NetworkManager: NetworkManagerProtocol {
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let imageCache:NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString,UIImage> ()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    var recipesUrl: URL? = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    
    // MARK: Network Calls
    
    func fetchAllRecipes() async throws -> [Recipe] {
        guard let url = recipesUrl else {
            throw NetworkError.invalidUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try decoder.decode(RecipesResponse.self, from: data)
            return decodedData.recipes
        }
        catch(_ as URLError) {
            throw NetworkError.invalidUrl
        }
        catch {
            throw NetworkError.invalidData
        }
    }
    
    func downloadImage(urlString: String) async throws -> UIImage {
        let cacheKey = NSString(string: urlString)
        
        if let image = imageCache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string:urlString) else {
            throw NetworkError.invalidUrl
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidData
            }
            imageCache.setObject(image, forKey: cacheKey)
            return image
        }
        catch {
            throw NetworkError.invalidData
        }
    }
}
