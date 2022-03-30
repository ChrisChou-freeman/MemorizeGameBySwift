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
        VStack{
            self.gameBody
            self.shuffle
        }
        .padding()
    }
    
    var gameBody: some View{
        AspectVGrid(items: self.emojiGame.cards, aspectRation: 2/3){ card in
            if card.isMatched && !card.isFaceUp{
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        withAnimation{
                            self.emojiGame.choose(card)
                        }
                    }
            }
        }
    }
    
    var shuffle: some View{
        Button("Shuffle"){
            withAnimation{
                self.emojiGame.shuffle()
            }
        }
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
