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
        if viewModel.favourites.isEmpty {
            VStack(spacing: 100) {
                Text("No Favourite")
                // TODO: change the destination
                NavigationLink(destination: CatFactListView().environmentObject(viewModel)) {
                    Text("View slide show of random cat facts")
                }
            }
        }
        else {
            ChangingView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlideShowView()
    }
}
