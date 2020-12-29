//
//  Digest.swift
//  Reciplease
//
//  Created by Fabrice Ortega on 23/12/2020.
//

import Foundation

struct Digest: Decodable, Equatable {
    var label: String?
    var tag: String?
    var schemaOrgTag: String?
    var total: Double?
    var hadRDI: Bool?
    var daily: Double?
    var unit: String?
    var sub: [SubDigest]?
}
