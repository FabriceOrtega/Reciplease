//
//  Recipe.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 23/12/2020.
//

import Foundation

import Foundation

struct Recipe: Decodable, Equatable {
    var uri: String?
    var label: String?
    var image: String?
    var source: String?
    var url: String?
    var shareAs: String?
    var yield: Double?
    var dietLabels: [String]?
    var healthLabels: [String]?
    var cautions: [String]?
    var ingredientLines: [String]?
    var calories: Double?
    var totalWeight: Double?
    var totalTime: Double?
    var ingredients: [Ingredient]?
    var totalNutrients: TotalNutrients?
    var totalDaily: TotalDaily?
    var digset: [Digest]?
}


