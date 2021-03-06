//
//  CatFactApp.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import SwiftUI

@main
struct CatFactApp: App {
    let viewModel = CatFactViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .environmentObject(viewModel)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.primary)
            .tint(.pink)
        }
    }
}
