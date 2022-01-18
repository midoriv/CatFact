//
//  CatFact.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation

struct CatFact: Identifiable, Codable {
    var fact: String
    var id: String {
        return fact
    }
}
