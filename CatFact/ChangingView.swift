//
//  ChangingView.swift
//  CatFact
//
//  Created by Midori Verdouw on 19/1/22.
//

import SwiftUI

struct ChangingView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
        
    var body: some View {
        VStack {
            Text(viewModel.catFacts[viewModel.currentFactIndex].fact)
        }
        .onAppear {
            viewModel.startTimer()
        }
        .id(viewModel.currentFactIndex)
        .transition(
            AnyTransition
                .asymmetric(insertion: .opacity, removal: .identity)
                .animation(.easeInOut(duration: 1))
        )
    }
}
