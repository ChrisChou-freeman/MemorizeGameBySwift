//
//  MemoryGame.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairsCards: Int, createCardContent: (Int) -> CardContent){
        self.cards = Array<Card>()
        for pairIndex in 0...numberOfPairsCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    
    func choose(_ card: Card) {
        // choose a card
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
