//
//  GameView.body.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI


extension GameView{
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
}
