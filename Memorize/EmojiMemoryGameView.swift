//
//  ContentView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    
    var body: some View {
        ScrollView{
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 65))]
            ){
                ForEach(self.emojiGame.cards){ card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            self.emojiGame.choose(card)
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CardView: View{
    let card: EmojiMemoryGame.Card
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRaius)
                if self.card.isFaceUp{
                    shape.foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.shapBorderWidth)
                    Text(self.card.content).font(font(in: geometry.size))
                } else if self.card.isMatched{
                    shape.opacity(0)
                }
                else{
                    shape
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
        static let cornerRaius: CGFloat = 20
        static let shapBorderWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.8
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(emojiGame: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
