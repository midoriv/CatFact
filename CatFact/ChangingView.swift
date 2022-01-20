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
        GeometryReader { geometry in
            ZStack {
                viewModel.getBackgroundColor()
                
                VStack {
                    Group {
                        Image(viewModel.getImageName())
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                                        
                    Text(viewModel.catFacts[viewModel.currentFactIndex].fact)
                        .padding()
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
    }
}
