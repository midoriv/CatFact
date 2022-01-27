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
            // if favourite item exist
            if viewModel.useFavourites {
                ChangingView().environmentObject(viewModel)
            }
            else {
                VStack(spacing: 100) {
                    Text("No Favourite")
                    NavigationLink(destination: ChangingView().environmentObject(viewModel)) {
                        Text("View slide show of random cat facts")
                    }
                }
            }
        }
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
