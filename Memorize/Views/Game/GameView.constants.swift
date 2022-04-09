//
//  GameView.constants.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI

extension GameView{
    struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWidth = undealHeight * aspectRatio
    }
}
