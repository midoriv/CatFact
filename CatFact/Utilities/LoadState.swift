//
//  LoadState.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation

enum LoadState {
    case idle
    case loading
    case failed(Error)
    case loaded
}
