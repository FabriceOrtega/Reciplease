//
//  Hit.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 23/12/2020.
//

import Foundation

struct Hit: Decodable, Equatable {
    var recipe: Recipe
    var bookmarked: Bool
    var bought: Bool
}


