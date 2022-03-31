//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojiFood = ["🧀", "🥚", "🍳", "🥞", "🧇", "🧈", "🍞", "🥐", "🥯", "🥖",
                     "🥨", "🍔", "🍟", "🌭", "🍕", "🥪", "🌮", "🌯", "🥙", "🧆",
                     "🍝", "🍛", "🥘", "🍲", "🍤", "🥗", "🥫"]
    static let emojiVehicle = ["🚃", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞",
                        "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚕",
                        "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛"]
    
    @Published private var model = createMemryGame()
    
    private static func createMemryGame() -> MemoryGame<String>{
        MemoryGame(numberOfPairsCards: 10) { pairIndex in
            emojiVehicle[pairIndex]
        }
    }
    
    var cards: [Card]{
        return self.model.cards
    }
    
    // MARK: - choose
    func choose(_ card: Card){
        self.model.choose(card)
    }
    
    func shuffle(){
        self.model.shuffle()
    }
    
    func restart(){
        self.model = EmojiMemoryGame.createMemryGame()
    }
}
