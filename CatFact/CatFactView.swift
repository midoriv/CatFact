//
//  CatFactView.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import SwiftUI

struct CatFactView: View {
    @StateObject private var viewModel = CatFactViewModel()
    
    var body: some View {
        Group {
            switch viewModel.loadState {
            case .idle, .loading:
                ProgressView("Loading...")
            case let .loaded(catFacts):
                List(catFacts) { catFact in
                    Text(catFact.fact)
                }
            case .failed:
                Text("Failed")
            }
        }
        .task {
            await viewModel.loadCatFacts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactView()
    }
}
