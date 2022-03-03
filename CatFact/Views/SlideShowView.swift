//
//  SlideShowView.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import SwiftUI

struct SlideShowView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    var body: some View {
        Group {
            // if favourite item does not exist
            if viewModel.favourites.isEmpty {
                SingleMessageView(message: "No favourite yet...")
            }
            else {
                VStack(spacing: 100) {
                    NavigationLink(destination: ChangingView().environmentObject(viewModel)) {
                        Text("View slide show of your favourite cat facts")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.setSlideShowMode(.favourite)
                    })
                    
                    NavigationLink(destination: ChangingView().environmentObject(viewModel)) {
                        Text("View slide show of random cat facts")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.setSlideShowMode(.random)
                    })
                }
            }
        }
        .layBackground()
        .onAppear {
            viewModel.setCurrentFactIndex(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlideShowView()
    }
}
