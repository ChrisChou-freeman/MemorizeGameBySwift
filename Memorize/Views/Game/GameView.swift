//
//  GameView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiGame: MemoryGameHandler
    @State private var dealt = Set<Int>()
    @Namespace var dealingNamespace
    var theme: EmojiData.EmojiTheme
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                Text("Score: \(self.emojiGame.score)")
                    .bold()
                self.gameBody
                HStack{
                    self.restart
                    Spacer()
                    self.shuffle
                }
                .padding(.horizontal)
            }
            self.deckBody
        }
        .padding()
    }
    
    func zIndex(of card: MemoryGameHandler.Card) -> Double{
        -Double(self.emojiGame.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    func deal(_ card: MemoryGameHandler.Card){
        dealt.insert(card.id)
    }
    
    func isUpdealt(_ card: MemoryGameHandler.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    func dealAnimation(for card: MemoryGameHandler.Card) -> Animation {
        var delay = 0.0
        if let index = self.emojiGame.cards.firstIndex(where: { $0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(self.emojiGame.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var shuffle: some View{
        Button("Shuffle"){
            withAnimation{
                self.emojiGame.shuffle()
            }
        }
    }
    
    var restart: some View{
        Button("Restart"){
            withAnimation{
                self.dealt = []
                self.emojiGame.restart(with: self.theme)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static let game = MemoryGameHandler(with: .food)
    static var previews: some View {
        return GameView(emojiGame: game, theme: .food)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
