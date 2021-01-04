//
//  Favorites.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 28/12/2020.
//

import Foundation

class Favorites {
    // Pattern singleton
    static public let favorites = Favorites()
    
    // Array of favorite recipes
    var favoriteRecipesArray: [Recipe] = []
    
    // Public init for pattern singleton
    public init() {}
    
    // Method to add to favorite
    func addToFavorite(recipe: Recipe){
        Favorites.favorites.favoriteRecipesArray.append(recipe)
    }
    
    // Method to remove from favorites
    func removeFromFavorites(index: Array<Recipe>.Index){
        favoriteRecipesArray.remove(at: index)
    }
    
    
    // Method to charge data from database
    func fillFavoriteRecipeArray() {
        
        for recipe in RecipeEntity.all {
            
            // create a Recipe object
            var recipeToAppend = Recipe()
            recipeToAppend.label = recipe.label
            recipeToAppend.image = recipe.image
            recipeToAppend.totalTime = recipe.totalTime
            recipeToAppend.url = recipe.url
            recipeToAppend.ingredientLines = recipe.ingredientLine?.components(separatedBy: ",")
            
            // Append in favorite recipe array
            addToFavorite(recipe: recipeToAppend)
            
        }
    }
    
    
}
