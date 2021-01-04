//
//  RecipeEntity.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 30/12/2020.
//

import Foundation
import CoreData

class RecipeEntity: NSManagedObject {
    static var all: [RecipeEntity] {
        
        // Charge and display saved data
        let request: NSFetchRequest<RecipeEntity> = RecipeEntity.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return recipes
    }
}
