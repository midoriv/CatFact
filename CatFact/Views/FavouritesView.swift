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
            SingleMessageView(message: "No favourite yet...")
        }
        else {
            List {
                ForEach(viewModel.favourites) { catFact in
                    Text(catFact.fact)
                }
                .onDelete { indexSet in
                    viewModel.favourites.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Favourites")
        }
    }
}


struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
