//
//  ContentView.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatFactViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                viewModel.loadCatFact()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
