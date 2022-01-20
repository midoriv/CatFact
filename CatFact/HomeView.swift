//
//  HomeView.swift
//  CatFact
//
//  Created by Midori Verdouw on 20/1/22.
//

import SwiftUI

struct HomeView: View {
    let viewModel = CatFactViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                
                VStack {
                    // TODO: only samples
                    NavigationLink(destination: CatFactView().environmentObject(viewModel)) {
                        Text("Option 1")
                    }
                    NavigationLink(destination: CatFactView().environmentObject(viewModel)) {
                        Text("Option 2")
                    }
                    NavigationLink(destination: CatFactView().environmentObject(viewModel)) {
                        Text("Option 3")
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
