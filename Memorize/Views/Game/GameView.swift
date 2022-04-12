//
//  GameView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: MemoryGameHandler
    @State private var dealt = Set<Int>()
    @Namespace var dealingNamespace
    var theme: EmojiData.EmojiTheme
    
    init(theme: EmojiData.EmojiTheme){
        self.theme = theme
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                Text("Score: \(self.game.score)")
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
        .onAppear{
            self.game.start(with: self.theme)
        }
    }
    
    func zIndex(of card: MemoryGameHandler.Card) -> Double{
        -Double(self.game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    func deal(_ card: MemoryGameHandler.Card){
        dealt.insert(card.id)
    }
    
    func isUpdealt(_ card: MemoryGameHandler.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    func dealAnimation(for card: MemoryGameHandler.Card) -> Animation {
        var delay = 0.0
        if let index = self.game.cards.firstIndex(where: { $0.id == card.id }){
            delay = Double(index) * (CardConstants.totalDealDuration / Double(self.game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    var shuffle: some View{
        Button("Shuffle"){
            withAnimation{
                self.game.shuffle()
            }
        }
    }
    
    var restart: some View{
        Button("Restart"){
            withAnimation{
                self.dealt = []
                self.game.restart(with: self.theme)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var game = MemoryGameHandler()
    static var previews: some View {
        return GameView(theme: .food)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
            .environmentObject(game)
    }
}
