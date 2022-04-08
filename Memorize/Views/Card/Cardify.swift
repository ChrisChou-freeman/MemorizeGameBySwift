//
//  Cardify.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/29.
//

import SwiftUI

struct Cardify: AnimatableModifier{
    var rotation: Double
    var animatableData: Double {
        get{self.rotation}
        set{self.rotation = newValue}
    }
    
    init(isFaceUp: Bool) {
        self.rotation = isFaceUp ? 0 : 180
    }
    
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRaius)
            if self.rotation < 90{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.shapBorderWidth)
            } else{
                shape.fill()
            }
            content.opacity(self.rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(self.rotation), axis: (0, 1, 0))
    }
    
    private struct DrawingConstants{
        static let cornerRaius: CGFloat = 10
        static let shapBorderWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
    }
}

extension View {
    func cardify(isFaceup: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceup))
    }
}
