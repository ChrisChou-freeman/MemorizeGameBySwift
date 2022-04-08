//
//  MemoryGame.Card.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import Foundation

extension MemoryGame{
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
