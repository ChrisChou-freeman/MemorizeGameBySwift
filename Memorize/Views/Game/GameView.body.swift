//
//  GameView.body.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI


extension GameView{
    var gameBody: some View {
        return AspectVGrid(items: self.game.cards, aspectRation: 2/3){ card in
            Group{
                if self.isUpdealt(card) || (card.isMatched && !card.isFaceUp) || self.discardArray.contains(card.id){
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
                                self.game.choose(card)
                                self.discard()
                            }
                        }
                }
            }
            .foregroundColor(Color.colorFromHex(hex: card.color.rawValue.convertHexStringToInt()))
        }
    }
}
