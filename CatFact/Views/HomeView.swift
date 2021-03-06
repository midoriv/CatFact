//
//  HomeView.swift
//  CatFact
//
//  Created by Midori Verdouw on 20/1/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if isLandscape(geometry) {
                    landscapeBody
                }
                else {
                    portraitBody
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .layBackground()
        .navigationBarTitle(Text("Home"), displayMode: .inline)
        .navigationBarHidden(true)
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
            default:
                break
            }
        }
    }
    
    var portraitBody: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                VStack() {
                    Image("cat7")
                        .resizable()
                        .scaledToFit()
                        .offset(y: 30)
                    
                    Text("Cat Fact")
                        .font(.system(size: 70, weight: .bold, design: .serif))
                        .offset(y: -30)
                        .foregroundColor(Color.customColor(red: 245.0, green: 151.0, blue: 142))
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                
                optionsView
            }
        }
    }
    
    var optionsView: some View {
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
    
    var landscapeBody: some View {
        GeometryReader { geometry in
            HStack(spacing: 30) {
                VStack() {
                    Image("cat7")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Cat Fact")
                        .font(.system(size: 70, weight: .bold, design: .serif))
                        .foregroundColor(Color.customColor(red: 245.0, green: 151.0, blue: 142))
                }
                .frame(width: geometry.size.width * 0.4, height: geometry.size.height)
                
                optionsView
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
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
            .environmentObject( CatFactViewModel())
    }
}
