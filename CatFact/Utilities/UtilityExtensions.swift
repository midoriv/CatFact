//
//  UtilityExtensions.swift
//  CatFact
//
//  Created by Midori Verdouw on 20/1/22.
//

import SwiftUI

extension Color {
    static func customColor(red: Double, green: Double, blue: Double) -> Color {
        let max = 255.0
        return Color(red: red/max, green: green/max, blue: blue/max)
    }
}

