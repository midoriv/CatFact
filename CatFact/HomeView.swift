//
//  HomeView.swift
//  CatFact
//
//  Created by Midori Verdouw on 20/1/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    NavigationLink(destination: CatFactListView().environmentObject(viewModel)) {
                        OptionView(optionName: "Dicover")
                    }
                    .simultaneousGesture(TapGesture().onEnded{
                        viewModel.clearCatFacts()
                    })
                    
                    NavigationLink(destination: FavouritesView().environmentObject(viewModel)) {
                        OptionView(optionName: "Favourites")
                    }
                    NavigationLink(destination: SlideShowView().environmentObject(viewModel)) {
                        OptionView(optionName: "Slide Show")
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
    let textColor = Color.customColor(red: 255.0, green: 250.0, blue: 240)
    let backgroundColor = Color.customColor(red: 70.0, green: 130.0, blue: 180.0)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(backgroundColor)
            
            HStack() {
                Image("flower1")
                    .resizable()
                    .frame(width: 40, height: 40)
                Spacer()
                Text(optionName)
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .foregroundColor(textColor)
                Spacer()
            }
            .padding()
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
