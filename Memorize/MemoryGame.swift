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
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of: card)
        if chosenIndex == -1{
            return
        }
        self.cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int{
        for index in 0..<self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return -1
    }
    
    struct Card: Identifiable {
        var content: CardContent
        var id: Int
        var isFaceUp = true
        var isMatched = false
    }
}
