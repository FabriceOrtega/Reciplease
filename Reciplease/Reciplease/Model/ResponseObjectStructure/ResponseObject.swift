//
//  ResponseObject.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 22/12/2020.
//

import Foundation

struct ResponseObject: Decodable, Equatable {
    var q: String
    var from: Int
    var to: Int
    var more: Bool
    var count: Int
    var hits: [Hit]
}


