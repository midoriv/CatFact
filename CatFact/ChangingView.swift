//
//  ChangingView.swift
//  CatFact
//
//  Created by Midori Verdouw on 19/1/22.
//

import SwiftUI

struct ChangingView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    var collection: [CatFact] {
        switch viewModel.slideShowMode {
        case .favourite:
            return viewModel.favourites
        case .random:
            return viewModel.catFacts
        }
    }

    var body: some View {
        switch viewModel.slideShowMode {
        case .favourite:
            changingView
        case .random:
            Group {
                switch viewModel.loadState {
                case .idle, .loading:
                    LoadingView()
                case .loaded:
                    changingView
                case .failed:
                    Text("Failed")
                }
            }
            .task {
                viewModel.clearCatFacts()
                await viewModel.loadCatFacts()
            }
        }
    }
    
    var changingView: some View {
        GeometryReader { geometry in
            ZStack {
                Resources.getBackgroundColor()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Group {
                        Image(Resources.getImageName())
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    
                    Text(collection[viewModel.currentFactIndex].fact).padding()
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
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
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}
