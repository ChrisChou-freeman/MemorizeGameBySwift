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
    @State var discardArray: [Int] = []
    @Namespace var dealingNamespace
    var theme: String
    
    init(theme: String){
        self.theme = theme
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
                Text("Score: \(self.game.score)")
                    .bold()
                self.gameBody
                HStack{
                    Spacer()
                    self.discardPile
                        .padding(.trailing, 10)
                }
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
    
    func discard(){
        for card in game.cards{
            if card.isMatched{
                discardArray.append(card.id)
            }
        }
    }
    
    func isMatched(_ card: MemoryGameHandler.Card) -> Bool {
        card.isMatched
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
                self.discardArray = []
                self.game.restart(with: self.theme)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var game = MemoryGameHandler()
    static var previews: some View {
        return GameView(theme: "food")
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
            .environmentObject(game)
    }
}
