//
//  ContentView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

struct ContentView: View {
    var emojiGameModel: EmojiMemoryGame
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 65))]
                ){
                    ForEach(self.emojiGameModel.cards[0..<emojiCount], id: \.content.self){ card in
                        CardView(content: card.content)
                            .aspectRatio(2/3, contentMode: .fit)
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
