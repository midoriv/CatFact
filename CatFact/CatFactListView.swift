//
//  CatFactListView.swift
//  CatFact
//
//  Created by Midori Verdouw on 21/1/2022.
//

import SwiftUI

struct CatFactListView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    var body: some View {
        Group {
            switch viewModel.loadState {
            case .idle, .loading:
                loadingView
            case .loaded:
                catFactList
            case .failed:
                Text("Failed")
            }
        }
        .task {
            await viewModel.loadCatFacts()
        }
    }
    
    var catFactList: some View {
        GeometryReader { geometry in
            
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.catFacts) { catFact in
                            RowView(catFact: catFact, geometry: geometry)
                            Image("cat2")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }
                    }
                    
                    Button(action: {
                        
                    }) {
                        Text("Load more")
                    }
                    .padding(40)
                }
                .padding(.top, 40)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarTitle(Text("Discover"), displayMode: .inline)
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
    
    func RowView(catFact: CatFact, geometry: GeometryProxy) -> some View {
        HStack {
            Text(catFact.fact)
                .padding(.trailing, 20)
            Spacer()
            Button(action: {
                viewModel.addFavourite(catFact.id)
            }) {
                Image(systemName: "heart")
            }
        }
        .frame(width: geometry.size.width * 0.8)
        .padding()
    }
}

struct CatFactListView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactListView()
    }
}
