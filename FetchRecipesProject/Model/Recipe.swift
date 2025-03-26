//
//  Recipes.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/22/25.
//

import Foundation

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let uuid: String
    let name: String
    let cuisine: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let youtubeUrl: String?
}

extension Recipe: Identifiable {
    var id: String { return uuid }
}

// MARK: Mock data for previews

struct MockData {
    static let sampleRecipe = Recipe(uuid: "001",
                                     name: "Apam Balik",
                                     cuisine: "Malaysian",
                                     photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                                     photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                                     sourceUrl: nil,
                                     youtubeUrl: nil)
    
    static let recipes = [sampleRecipe, sampleRecipe, sampleRecipe]
}
