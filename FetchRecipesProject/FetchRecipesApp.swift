//
//  FetchRecipesProjectApp.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/22/25.
//

import SwiftUI

@main
struct FetchRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            let networkManager = NetworkManager()
            let viewModel = RecipesViewModel(networkManager: networkManager)
            
            RecipesView(viewModel: viewModel)
        }
    }
}
