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
    
    @Published private var model = MemoryGame(numberOfPairsCards: 4) { pairIndex in
        emojiFood[pairIndex]
    }
    
    var cards: [Card]{
        return self.model.cards
    }
    
    // MARK: - choose
    func choose(_ card: Card){
        self.model.choose(card)
    }
}
