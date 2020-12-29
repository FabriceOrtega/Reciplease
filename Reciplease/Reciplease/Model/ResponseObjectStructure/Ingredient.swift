//
//  Ingredient.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 23/12/2020.
//

import Foundation

struct Ingredient: Decodable, Equatable {

    var text: String?
    var weight: Double?
    var image: String?
}
