//
//  FavoritesTestCase.swift
//  RecipleaseUnitTests
//
//  Created by Fabrice Ortega on 29/12/2020.
//

import Foundation

import XCTest
@testable import Reciplease

class FavoritesTestCase: XCTestCase {
    // Test if favorite array appends
    func testGivenFavoritesArrayIsEmptyWhenAddingOneThenArrayShouldHaveOneElement() {
        Favorites.favorites.favoriteRecipesArray = []
        
        let favoriteRecipe = Recipe()
        Favorites.favorites.addToFavorite(recipe: favoriteRecipe)
        
        XCTAssert(Favorites.favorites.favoriteRecipesArray.count == 1)
    }
    
    // Test for recipe removal in favorite array
    func testGivenFavoritesArrayhasOneElementWhenRemovingOneThenArrayShouldBeEmpty() {
        let favoriteRecipe = Recipe()
        Favorites.favorites.favoriteRecipesArray = [favoriteRecipe]
        
        Favorites.favorites.removeFromFavorites(index: 0)
        
        XCTAssert(Favorites.favorites.favoriteRecipesArray.count == 0)
    }
    
}
