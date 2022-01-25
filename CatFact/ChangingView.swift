//
//  ChangingView.swift
//  CatFact
//
//  Created by Midori Verdouw on 19/1/22.
//

import SwiftUI

struct ChangingView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    var isRandomMode: Bool {
        willSet {
            if isRandomMode {
                viewModel.setFavouritesMode()
            }
        }
    }
    
    var body: some View {
        if isRandomMode {
            Group {
                switch viewModel.loadState {
                case .idle, .loading:
                    loadingView
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
        else {
            changingView
        }
    }
    
    var changingView: some View {
        GeometryReader { geometry in
            ZStack {
                viewModel.getBackgroundColor()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Group {
                        Image(viewModel.getImageName())
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                    
                    Text(viewModel.catFacts[viewModel.currentFactIndex].fact).padding()
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
    
    var loadingView: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image("cat1")
                    .resizable()
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.2)
                ProgressView("Loading...")
            }
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}
