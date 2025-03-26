//
//  ContentView.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/22/25.
//

import SwiftUI

struct RecipesView: View {
    @ObservedObject var viewModel: RecipesViewModel
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(viewModel.recipes) { recipe in
                    RecipeCell(recipe: recipe,
                               imageLoader: viewModel.imageLoader())
                        .listRowSeparator(.hidden)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    LoadingView()
                }
                else if viewModel.recipes.isEmpty {
                    ContentUnavailableView("No Recipes",
                                           systemImage: "text.document.fill")
                }
            }
            .listStyle(.plain)
            .navigationTitle("👩🏽‍🍳 Recipes")
            .background(Color.defaultBackground)
            .refreshable {
                viewModel.fetchRecipes()
            }
            .alert("Something went wrong", isPresented: $viewModel.showAlert) {
                Button("OK") {
                    viewModel.alertDismissed()
                }
            }
        }
        .task {
            viewModel.fetchRecipes()
        }
    }
}

#Preview {
    RecipesView(viewModel: RecipesViewModel(networkManager: NetworkManager()))
}
