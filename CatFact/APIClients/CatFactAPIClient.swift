//
//  CatFactAPIClient.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation
import Combine

struct CatFactAPIClient {
    func getCatFact() -> AnyPublisher<CatFact, Error> {
        let url = URL(string: "https://catfact.ninja/fact")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/json"
        ]
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { response -> Data in
                guard let httpURLResponse = response.response as? HTTPURLResponse,
                      httpURLResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return response.data
            }
            .decode(type: CatFact.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
