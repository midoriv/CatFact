//
//  Constants.swift
//  CatFact
//
//  Created by Midori Verdouw on 9/2/2022.
//

import Foundation
import SwiftUI

struct Resources {
    // https://sozai-good.com/illust/animal/cat?category_id=174
    private static let imageNames = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8", "cat9", "cat10"]

    // https://www.rapidtables.com/web/color/RGB_Color.html
    private static let backgroundColors = [
        "mistyRose": Color.customColor(red: 255.0, green: 228.0, blue: 225.0),
        "lightCoral": Color.customColor(red: 240.0, green: 128.0, blue: 128.0),
        "paleGreen": Color.customColor(red: 152.0, green: 251.0, blue: 152.0),
        "paleTurquoise": Color.customColor(red: 175.0, green: 238.0, blue: 238.0),
        "skyBlue": Color.customColor(red: 135.0, green: 206.0, blue: 235.0),
        "thistle": Color.customColor(red: 216.0, green: 191.0, blue: 216.0),
        "lightPink": Color.customColor(red: 255.0, green: 182.0, blue: 193.0),
        "beige": Color.customColor(red: 245.0, green: 245.0, blue: 220.0),
        "lemonChiffon": Color.customColor(red: 255.0, green: 250.0, blue: 205.0),
        "lavender": Color.customColor(red: 230.0, green: 230.0, blue: 250.0),
    ]
    
    static func getImageName() -> String {
        imageNames[Int.random(in: 0..<imageNames.count)]
    }
    
    static func getBackgroundColor() -> Color {
        backgroundColors.randomElement()!.value
    }
}
