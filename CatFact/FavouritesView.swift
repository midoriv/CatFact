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
        List(viewModel.favourites, id: \.self) { fav in
            Text(fav)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
