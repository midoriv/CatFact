//
//  CatFactView.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import SwiftUI

struct CatFactView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    @State var currentIndex = 0
    
    var body: some View {
        Group {
            switch viewModel.loadState {
            case .idle, .loading:
                loadingView
            case .loaded:
                ChangingView(currentIndex: currentIndex)
                
            case .failed:
                Text("Failed")
            }
        }
        .padding()
        .task {
            await viewModel.loadCatFacts()
        }
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
    
    var catFactView: some View {
        VStack(spacing: 20) {
            Text(viewModel.catFacts[currentIndex].fact)
            HStack {
                Button(action: {
                    currentIndex = (currentIndex == 0) ? viewModel.catFacts.count - 1 : currentIndex - 1
                }) {
                    Image(systemName: "arrow.left")
                }
                Spacer()
                Button(action: {
                    currentIndex = (currentIndex + 1) % viewModel.catFacts.count
                }) {
                    Image(systemName: "arrow.right")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactView()
    }
}
