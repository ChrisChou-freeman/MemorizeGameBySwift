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
        AspectVGrid(items: self.emojiGame.cards, aspectRation: 2/3){ card in
            if card.isMatched && !card.isFaceUp{
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        self.emojiGame.choose(card)
                    }
            }
        }
        .padding(.horizontal)
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
