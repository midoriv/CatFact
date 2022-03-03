//
//  SingleMessageView.swift
//  CatFact
//
//  Created by Midori Verdouw on 2/3/2022.
//

import SwiftUI

struct SingleMessageView: View {
    var message: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Image("cat10")
                    .resizable()
                    .scaledToFit()
                    .frame(width: getContentWidth(in: geometry), height: getContentHeight(in: geometry))
                Text(message)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .layBackground()
    }
    
    func getContentWidth(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width < geometry.size.height ?
            geometry.size.width : geometry.size.width * 0.25
    }
    
    func getContentHeight(in geometry: GeometryProxy) -> CGFloat {
        geometry.size.width < geometry.size.height ?
        geometry.size.height * 0.3 : geometry.size.height * 0.6
    }
}

struct SingleMessageView_Previews: PreviewProvider {
    static var previews: some View {
        SingleMessageView(message: "No favourite yet...")
.previewInterfaceOrientation(.landscapeRight)
    }
}
