//
//  FavouritesView.swift
//  CatFact
//
//  Created by Midori Verdouw on 25/1/2022.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    var body: some View {
        if viewModel.favourites.isEmpty {
            noFavouriteView
        }
        else {
            List(viewModel.favourites) { catFact in
                Text(catFact.fact)
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
            
                VStack(alignment: .center) {
                    Image("cat10")
                        .resizable()
                        .scaledToFit()
                    Text("No favourite yet...")
                }
                .frame(width: getContentWidth(in: geometry), height: getContentHeight(in: geometry))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    func getContentWidth(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width < geometry.size.height ?
            geometry.size.width : geometry.size.width * 0.25
    }
    
    func getContentHeight(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width < geometry.size.height ?
        geometry.size.height * 0.3 : geometry.size.height
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
