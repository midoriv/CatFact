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
        if viewModel.catFacts.isEmpty {
            Group {
                switch viewModel.loadState {
                case .idle, .loading:
                    LoadingView()
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
        else {
            catFactList
        }
    }
    
    var catFactList: some View {
        GeometryReader { geometry in
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                
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
                    .padding([.top, .bottom], isLandscape(in: geometry) ? 50 : 10)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarTitle(Text("Discover"), displayMode: .inline)
    }
    
    func isLandscape(in geometry: GeometryProxy) -> Bool {
        geometry.size.width > geometry.size.height
    }
    
    func RowView(catFact: CatFact, geometry: GeometryProxy) -> some View {
        HStack {
            Text(catFact.fact)
                .padding(.trailing, 20)
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
        .frame(width: geometry.size.width * 0.8)
        .padding()
    }
}

struct CatFactListView_Previews: PreviewProvider {
    static var previews: some View {
        CatFactListView()
    }
}
