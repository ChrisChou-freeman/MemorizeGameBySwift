//
//  CardView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/25.
//

import SwiftUI

struct CardView: View{
    let card: EmojiMemoryGame.Card
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack {
                Pie(
                    startAngle: Angle(degrees: 0-90),
                    endAngle: Angle(degrees: 10-90)
                )
                    .padding(5)
                    .opacity(0.5)
                Text(self.card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360: 0))
                    .animation(Animation.linear(duration: 1), value: self.card.isMatched)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(self.scale(thatFits: geometry.size))
            }
            .cardify(isFaceup: self.card.isFaceUp)
            .foregroundColor(.red)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font{
        Font.system(
            size: min(size.width, size.height) * DrawingConstants.fontScale
        )
    }
    
    private struct DrawingConstants{
        static let fontScale: CGFloat = 0.7
        static let fontSize: CGFloat = 32
    }
}

