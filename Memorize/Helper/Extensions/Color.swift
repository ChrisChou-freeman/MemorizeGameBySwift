//
//  Color.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/14.
//

import SwiftUI


extension Color{
    static func colorFromHex(hex: Int) -> Self {
        return Color(
            red: Double((hex & 0xFF0000) >> 16) / 255.0,
            green: Double((hex & 0x00FF00) >> 8) / 255.0,
            blue: Double(hex & 0x0000FF) / 255.0
        )
    }
}
