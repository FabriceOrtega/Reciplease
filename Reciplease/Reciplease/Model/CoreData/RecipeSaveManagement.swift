//
//  RecipeSaveManagement.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 30/12/2020.
//

import Foundation
import CoreData

class RecipeSaveManagement {
    
    // Singleton pattern
    public static let recipeSaveManagement = RecipeSaveManagement()
    
    // Public init for pattern singleton
    public init() {}
    
    // MARK: Database Methods
    
    // Method to add a recipe in the database
    func saveRecipe(recipeToSave: Recipe) {
        // Save the object in the context
        let recipe = RecipeEntity(context: AppDelegate.viewContext)
        recipe.label = recipeToSave.label
        recipe.image = recipeToSave.image
        recipe.totalTime = recipeToSave.totalTime ?? 0
        recipe.url = recipeToSave.url
        recipe.ingredientLine = recipeToSave.ingredientLines?.joined(separator:",")
        
        // Save the context
        try? AppDelegate.viewContext.save()
    }
    
    // Method to remove a recipe from the database
    func removeRecipe(recipeToRemove: Recipe) {
        // Save the object in the context
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        if let recipes = try? AppDelegate.viewContext.fetch(request){
            for i in recipes {
                if i.label == recipeToRemove.label {
                    AppDelegate.viewContext.delete(i)
                }
            }
        }
        
        // Save the context
        try? AppDelegate.viewContext.save()
    }
    
}
