//
//  LayBackground.swift
//  CatFact
//
//  Created by Midori Verdouw on 3/3/2022.
//

import SwiftUI

// a view modifier applied to contents to lay the same background image
struct LayBackground: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                content
            }
        }
    }
}

extension View {
    func layBackground() -> some View {
        self.modifier(LayBackground())
    }
}
