//
//  Search.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 26/12/2020.
//

import Foundation

class Search {
    
    // Pattern singleton
    static public let searchClass = Search()
    
    // List of ingredient
    var ingredientList: [String] = []
    
    // List of ingredients for the request
    var ingredientListForResquest: String {
        ingredientList.joined(separator:"/")
    }
    
    // Public init for pattern singleton
    public init() {}
    
    // Method to add ingredient
    func addIngredient(ingredient: String){
        ingredientList.append(ingredient)
    }
    
    // Method to clear ingredients
    func clearIngredients() {
        ingredientList.removeAll()
    }
}
