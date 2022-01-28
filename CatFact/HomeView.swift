//
//  HomeView.swift
//  CatFact
//
//  Created by Midori Verdouw on 20/1/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                
                if orientation.isLandscape {
                    landscapeBody
                }
                else {
                    portraitBody
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarHidden(true)
        .onRotate { newOrientation in
            orientation = newOrientation
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
                .frame(width: getContentWidthForPortrait(in: geometry), height: getContentHeightForPortrait(in: geometry))
                
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
        }
    }
    
    func getContentWidthForPortrait(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width
    }
    
    func getContentHeightForPortrait(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.4
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
                .frame(width: getContentWidthForLandscape(in: geometry), height: getContentHeightForLandscape(in: geometry))
                
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
    }
    
    func getContentWidthForLandscape(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width * 0.4
    }
    
    func getContentHeightForLandscape(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.height
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

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}







struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject( CatFactViewModel())
    }
}
