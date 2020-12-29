//
//  SubDigest.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 24/12/2020.
//

import Foundation

struct SubDigest: Decodable, Equatable {
    var label: String?
    var tag: String?
    var schemaOrgTag: String?
    var total: Double?
    var hadRDI: Bool?
    var daily: Double?
    var unit: String?
}
