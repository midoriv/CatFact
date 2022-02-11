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
        ZStack {
            Image("homeBackground")
                .resizable()
                .scaledToFill()
                .opacity(0.9)
                .edgesIgnoringSafeArea(.all)
        
            Group {
                // if favourite item does not exist
                if viewModel.favourites.isEmpty {
                    noFavouriteView
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
            .onAppear {
                viewModel.setCurrentFactIndex(0)
            }
        }
    }
    
    var noFavouriteView: some View {
        GeometryReader { geometry in
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    
                VStack(spacing: 30) {
                    VStack {
                        Image("cat2")
                            .resizable()
                            .scaledToFit()
                        Text("No Favourite")
                    }
                    .frame(width: getContentWidth(in: geometry), height: getContentHeight(in: geometry))
                    
                    NavigationLink(destination: ChangingView().environmentObject(viewModel)) {
                        Text("Want to view random cat facts?")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.setSlideShowMode(.random)
                    })
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    func getContentWidth(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width < geometry.size.height ?
            geometry.size.width : geometry.size.width * 0.3
    }
    
    func getContentHeight(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width < geometry.size.height ?
        geometry.size.height * 0.3 : geometry.size.height * 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SlideShowView()
    }
}
