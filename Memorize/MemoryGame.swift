//
//  MemoryGame.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var indexOfTheOnlyFaceUpCard: Int? {
        get { self.cards.indices.filter{self.cards[$0].isFaceUp}.oneAndOnly }
        set{ self.cards.indices.forEach{ self.cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numberOfPairsCards: Int, createCardContent: (Int) -> CardContent){
        self.cards = []
        for pairIndex in 0..<numberOfPairsCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
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
                }
                self.cards[chosenIndex].isFaceUp = true
            }else{
                self.indexOfTheOnlyFaceUpCard = chosenIndex
            }
        }
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
    
    struct Card: Identifiable {
        let content: CardContent
        let id: Int
        var isFaceUp = false {
            didSet {
                if self.isFaceUp {
                    self.startUsingBonusTime()
                } else {
                    self.stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                self.stopUsingBonusTime()
            }
        }
        
        var bonusTimeLimit: TimeInterval = 6
        var pastFaceUpTime: TimeInterval = 0
        var lastFaceUpDate: Date?
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else{
                return pastFaceUpTime
            }
        }
        
        // how much time left vefore the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, self.bonusTimeLimit - self.faceUpTime)
        }
        
        // percentage of the bouns time remaining
        var bonusRemaining: Double{
            (self.bonusTimeLimit > 0 && self.bonusTimeRemaining > 0) ? self.bonusTimeRemaining / self.bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            self.isMatched && self.bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            self.isFaceUp && !self.isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime(){
            if self.isConsumingBonusTime, self.lastFaceUpDate == nil {
                self.lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            self.pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
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
