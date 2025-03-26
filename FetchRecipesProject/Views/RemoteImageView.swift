//
//  RemoteImageView.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/24/25.
//

import SwiftUI

struct RemoteImage: View {
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image(systemName: "fork.knife").resizable()
    }
}

struct RemoteImageView: View {
    @StateObject var imageLoader: ImageLoader
    
    let urlString: String?
    
    var body: some View {
        RemoteImage(image: imageLoader.image)
            .task {
                if let url = urlString {
                    imageLoader.load(fromUrlString: url)
                }
            }
    }
}
