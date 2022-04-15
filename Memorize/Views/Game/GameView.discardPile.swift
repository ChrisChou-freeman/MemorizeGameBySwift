//
//  GameView.discardPile.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/15.
//

import SwiftUI

extension GameView{
    var discardPile: some View{
        ZStack{
            ForEach(self.game.cards) { card in
                if self.discardArray.contains(card.id){
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .transition(
                            AnyTransition.asymmetric(
                                insertion: .identity,
                                removal: .identity
                            )
                        )
                        .foregroundColor(.colorFromHex(hex: card.color.rawValue.convertHexStringToInt()))
                        .zIndex(Double(self.discardArray.firstIndex(where: {$0 == card.id}) ?? 0))
                }
            }
        }
        .frame(width: CardConstants.undealWidth, height: CardConstants.undealHeight)
    }
}
