//
//  GameView.deckBody.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI



extension GameView{
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
}
