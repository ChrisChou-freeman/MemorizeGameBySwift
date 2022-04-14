//
//  MemoryGame.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { self.cards.indices.filter{self.cards[$0].isFaceUp}.oneAndOnly }
        set{ self.cards.indices.forEach{ self.cards[$0].isFaceUp = ($0 == newValue) } }
    }
    var score: Int = 0
    private var numberOfPairsCards: Int
    
    init(numberOfPairsCards: Int){
        self.numberOfPairsCards = numberOfPairsCards
    }
    
    mutating func loadCards(cardContents: [CardContent], color: EmojiData.EmojiColor){
        self.cards = []
        for pairIndex in 0..<numberOfPairsCards{
            cards.append(Card(content: cardContents[pairIndex], id: pairIndex*2, color: color))
            cards.append(Card(content: cardContents[pairIndex], id: pairIndex*2 + 1, color: color))
        }
        self.cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = self.cards.firstIndex(where: {$0.id == card.id}),
           !self.cards[chosenIndex].isFaceUp,
           !self.cards[chosenIndex].isMatched {
            if let potentialMatchIndex = self.indexOfTheOnlyFaceUpCard {
                if self.cards[chosenIndex].content == self.cards[potentialMatchIndex].content{
                    self.cards[chosenIndex].isMatched = true
                    self.cards[potentialMatchIndex].isMatched = true
                    self.score += 2
                }else{
                    self.markAndCountScore(for: chosenIndex, and: potentialMatchIndex)
                }
                self.cards[chosenIndex].isFaceUp = true
            }else{
                self.indexOfTheOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    private mutating func markAndCountScore(for chosenIndex: Int, and potentialMatchIndex: Int){
        if self.cards[chosenIndex].isFliped{
            self.score -= 1
        }
        if self.cards[potentialMatchIndex].isFliped{
            self.score -= 1
        }
        self.cards[chosenIndex].isFliped = true
        self.cards[potentialMatchIndex].isFliped = true
    }
    
    func index(of card: Card) -> Int?{
        for index in 0..<self.cards.count{
            if self.cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    
    mutating func shuffle(){
        self.cards.shuffle()
    }
    
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1{
            return self.first
        }else{
            return nil
        }
    }
}
