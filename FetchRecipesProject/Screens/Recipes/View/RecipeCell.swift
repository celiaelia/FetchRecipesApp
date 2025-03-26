//
//  RecipeCell.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/23/25.
//

import SwiftUI

struct RecipeCell: View {
    var recipe: Recipe
    var imageLoader: ImageLoader
    
    var body: some View {
        HStack {
            RemoteImageView(imageLoader: imageLoader,
                            urlString: recipe.photoUrlSmall)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 15))
                .padding(8)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.title3)
                    .padding(.bottom, 1)
                Text(recipe.cuisine)
                    .font(.caption)
                    .padding(4)
                    .background(.pink)
                    .clipShape(.rect(cornerRadius: 5))
            }
        }
        .padding(.vertical, 8)
        .listRowBackground(
                            RoundedRectangle(cornerRadius: 5)
                                .background(.clear)
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                                .shadow(radius: 5))
    }
    
}

#Preview {
    RecipeCell(recipe: MockData.sampleRecipe,
               imageLoader: ImageLoader(networkManager: NetworkManager()))
}
