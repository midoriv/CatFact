//
//  CatFactRepository.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation
import Combine

protocol CatFactRepository {
    func fetchCatFact() -> AnyPublisher<CatFact, Error>
}

struct CatFactDataRepository: CatFactRepository {
    func fetchCatFact() -> AnyPublisher<CatFact, Error> {
        CatFactAPIClient().getCatFact()
    }
}
