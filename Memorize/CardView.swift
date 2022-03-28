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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRaius)
                if self.card.isFaceUp{
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.shapBorderWidth)
                    Pie(
                        startAngle: Angle(degrees: 0-90),
                        endAngle: Angle(degrees: 10-90)
                    )
                        .padding(5)
                        .opacity(0.5)
                    Text(self.card.content).font(font(in: geometry.size))
                } else if self.card.isMatched{
                    shape.opacity(0)
                }
                else{
                    shape.fill()
                }
            }
            .foregroundColor(.red)
        }
    }
    
    private func font(in size: CGSize) -> Font{
        Font.system(
            size: min(size.width, size.height) * DrawingConstants.fontScale
        )
    }
    
    private struct DrawingConstants{
        static let cornerRaius: CGFloat = 10
        static let shapBorderWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
