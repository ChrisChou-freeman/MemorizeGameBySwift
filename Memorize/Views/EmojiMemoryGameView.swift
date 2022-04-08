//
//  ContentView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiGame: MemoryGameHandler
    @State private var dealt = Set<Int>()
    @Namespace private var dealingNamespace
    var theme: EmojiData.EmojiTheme
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack{
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
    
    var gameBody: some View {
        AspectVGrid(items: self.emojiGame.cards, aspectRation: 2/3){ card in
            if self.isUpdealt(card) || (card.isMatched && !card.isFaceUp){
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(
                        AnyTransition.asymmetric(
                            insertion: .identity,
                            removal: .opacity
                        )
                    )
                    .zIndex(self.zIndex(of: card))
                    .onTapGesture {
                        withAnimation{
                            self.emojiGame.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(CardConstants.color)
    }
    
    var deckBody: some View{
        ZStack{
            ForEach(self.emojiGame.cards.filter(self.isUpdealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(
                        AnyTransition.asymmetric(
                            insertion: .opacity,
                            removal: .identity
                        )
                    )
                    .zIndex(self.zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            for card in self.emojiGame.cards{
                withAnimation(self.dealAnimation(for: card)){
                    self.deal(card)
                }
            }
        }
    }
    
    private func zIndex(of card: MemoryGameHandler.Card) -> Double{
        -Double(self.emojiGame.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    private func deal(_ card: MemoryGameHandler.Card){
        dealt.insert(card.id)
    }
    
    private func isUpdealt(_ card: MemoryGameHandler.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: MemoryGameHandler.Card) -> Animation {
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
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealHeight: CGFloat = 90
        static let undealWidth = undealHeight * aspectRatio
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemoryGameHandler(with: .food)
        EmojiMemoryGameView(emojiGame: game, theme: .food)
            .preferredColorScheme(.dark)
            .previewInterfaceOrientation(.portrait)
    }
}
