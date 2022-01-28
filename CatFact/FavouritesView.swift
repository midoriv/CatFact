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
                .frame(width: geometry.size.width, height: geometry.size.height * 0.3)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
