//
//  ChangingView.swift
//  CatFact
//
//  Created by Midori Verdouw on 19/1/22.
//

import SwiftUI

struct ChangingView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    let currentIndex: Int   // TODO: move this to the view model?
    
    var body: some View {
        VStack {
            Text(viewModel.catFacts[currentIndex].fact)
        }
        .onAppear {
            
        }
    }
}

//struct ChangingView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChangingView()
//    }
//}
