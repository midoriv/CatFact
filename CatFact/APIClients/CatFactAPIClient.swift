//
//  CatFactAPIClient.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation
import Combine

struct CatFactAPIClient {
    func loadCatFacts() async throws -> [CatFact] {
        let url = URL(string: "https://catfact.ninja/fact")!
        
        return try await withThrowingTaskGroup(of: [CatFact].self) { group -> [CatFact] in
            for _ in 0...9 {
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let catFact = try JSONDecoder().decode(CatFact.self, from: data)
                    return [catFact]
                }
            }
            return try await group.reduce(into: [CatFact]()) { $0 += $1 }
        }
    }
}
