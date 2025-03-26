//
//  ImageLoader.swift
//  FetchRecipesProject
//
//  Created by Celia Marquez on 3/24/25.
//

import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: Image? = nil
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func load(fromUrlString urlString: String) {
        Task {
            do {
                let image = try await networkManager.downloadImage(urlString: urlString)
                self.image = Image(uiImage: image)
            }
            catch {
                // TODO: Fix hardcoded placeholder in RemoteImage
            }
        }
    }
}
