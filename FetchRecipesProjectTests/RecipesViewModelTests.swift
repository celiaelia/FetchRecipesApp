//
//  FetchRecipesProjectTests.swift
//  FetchRecipesProjectTests
//
//  Created by Celia Marquez on 3/22/25.
//

import XCTest
@testable import FetchRecipesProject

@MainActor
final class RecipesViewModelTests: XCTestCase {
    var networkManagerMock: NetworkManagerMock!
    var recipesViewModel: RecipesViewModel!

    override func setUpWithError() throws {
        networkManagerMock = NetworkManagerMock()
        recipesViewModel = RecipesViewModel(networkManager: networkManagerMock)
    }

    override func tearDownWithError() throws {
        networkManagerMock = nil
        recipesViewModel = nil
    }

    func testAllRecipes() throws {
        recipesViewModel.fetchRecipes()
        
        _ = XCTWaiter.wait(for: [expectation(description: "async await")], timeout: 0.1)

        XCTAssertEqual(recipesViewModel.recipes.count, 3)
        XCTAssert(recipesViewModel.showAlert == false)
    }
    
    func testEmptyRecipes() throws {
        networkManagerMock.result = .empty
        
        recipesViewModel.fetchRecipes()
        
        _ = XCTWaiter.wait(for: [expectation(description: "async await")], timeout: 0.1)
        
        XCTAssertEqual(recipesViewModel.recipes.count, 0)
        XCTAssert(recipesViewModel.showAlert == false)
    }
    
    func testMalformedData() throws {        
        networkManagerMock.result = .failed
        
        recipesViewModel.fetchRecipes()
        
        _ = XCTWaiter.wait(for: [expectation(description: "async await")], timeout: 0.1)
        
        XCTAssertEqual(recipesViewModel.recipes.count, 0)
        XCTAssert(recipesViewModel.showAlert == true)
    }

}
