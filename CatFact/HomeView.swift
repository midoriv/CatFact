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
                
                VStack(spacing: 30) {
                    // TODO: only samples
                    NavigationLink(destination: CatFactView().environmentObject(viewModel)) {
                        OptionView(optionName: "Option 1")
                    }
                    NavigationLink(destination: CatFactView().environmentObject(viewModel)) {
                        OptionView(optionName: "Option 2")
                    }
                    NavigationLink(destination: CatFactView().environmentObject(viewModel)) {
                        OptionView(optionName: "Option 3")
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarHidden(true)
    }
}

struct OptionView: View {
    let optionName: String
    
    var body: some View {
        ZStack {
            Color.white
            HStack {
                Text(optionName)
            }
        }
        .frame(width: 250, height: 60)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
