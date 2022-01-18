//
//  CatFact.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation

struct CatFact: Identifiable, Codable {
    var fact: String
    var id: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.fact = try container.decode(String.self, forKey: .fact)
    }
}
