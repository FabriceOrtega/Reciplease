//
//  NutrientInfo.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 23/12/2020.
//

import Foundation

struct NutrientInfo: Decodable, Equatable {
    var label: String?
    var quantity: Double?
    var unit: String?
}
