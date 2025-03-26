//
//  RecipesViewModel.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/23/25.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {

    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var showAlert = false

    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func imageLoader() -> ImageLoader {
        return ImageLoader(networkManager: networkManager)
    }

    func fetchRecipes() {
        isLoading = true
        Task {
            do {
                let latestRecipes = try await networkManager.fetchAllRecipes()
                isLoading = false
                recipes = latestRecipes
            }
            catch {
                isLoading = false
                showAlert = true
            }
        }
    }
    
    func alertDismissed() {
        showAlert = false
    }
}
