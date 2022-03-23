//
//  ContentView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var emojiGameModel: EmojiMemoryGame
    
    var body: some View {
        ScrollView{
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 65))]
            ){
                ForEach(self.emojiGameModel.cards){ card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            self.emojiGameModel.choose(card)
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(emojiGameModel: game)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
