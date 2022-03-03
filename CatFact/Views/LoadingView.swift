//
//  LoadingView.swift
//  CatFact
//
//  Created by Midori Verdouw on 25/1/2022.
//

import SwiftUI

struct LoadingView: View {
    @EnvironmentObject private var viewModel: CatFactViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image("cat1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: getWidth(in: geometry), height: getHeight(in: geometry))
                ProgressView("Loading...")
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    func getWidth(in geometry: GeometryProxy) -> CGFloat {
        if isLandscape(geometry) {
            return geometry.size.width * 0.7
        }
        else {
            return geometry.size.width * 0.6
        }
    }
    
    func getHeight(in geometry: GeometryProxy) -> CGFloat {
        if isLandscape(geometry) {
            return geometry.size.height * 0.4
        }
        else {
            return geometry.size.height * 0.2
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView().previewInterfaceOrientation(.landscapeLeft)
    }
}
