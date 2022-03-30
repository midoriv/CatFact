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
            if viewModel.catFacts.isEmpty {
                Group {
                    switch viewModel.loadState {
                    case .idle, .loading:
                        LoadingView()
                    case .loaded:
                        catFactList
                    case .failed:
                        SingleMessageView(message: "Loading failed.")
                    }
                }
                .task {
                    await viewModel.loadCatFacts()
                }
            }
            else {
                catFactList
            }
        }
        .navigationTitle("Discover")
    }
    
    var catFactList: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(viewModel.catFacts) { catFact in
                        RowView(catFact: catFact, geometry: geometry)
                        Image("cat2")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    
                    Group {
                        switch viewModel.loadState {
                        case .loading:
                            ProgressView("Loading...")
                            
                        case .idle, .loaded:
                            Button(action: {
                                Task {
                                    await viewModel.loadCatFacts()
                                }
                            }) {
                                Text("Load more")
                            }
                            
                        case .failed:
                            VStack(spacing: 10) {
                                Label("Loading failed", systemImage: "exclamationmark.triangle")
                                    .foregroundColor(.red)
                                
                                Button(action: {
                                    Task {
                                        await viewModel.loadCatFacts()
                                    }
                                }) {
                                    Text("Try again").foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .padding(40)
                }
                .padding([.top, .bottom], isLandscape(geometry) ? 50 : 10)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            
        }
        .layBackground()
    }
    
    func RowView(catFact: CatFact, geometry: GeometryProxy) -> some View {
        HStack(alignment: .center) {
            Text(catFact.fact)
            Spacer()
            Button(action: {
                viewModel.addFavourite(catFact)
            }) {
                if viewModel.favourites.contains { $0.fact == catFact.fact } {
                    Image(systemName: "heart.fill")
                }
                else {
                    Image(systemName: "heart")
                }
            }
        }
        .padding()
    }
}

struct CatFactListView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactListView()
    }
}
