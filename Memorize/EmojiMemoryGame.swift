//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    static let emojiFood = ["🧀", "🥚", "🍳", "🥞", "🧇", "🧈", "🍞", "🥐", "🥯", "🥖",
                     "🥨", "🍔", "🍟", "🌭", "🍕", "🥪", "🌮", "🌯", "🥙", "🧆",
                     "🍝", "🍛", "🥘", "🍲", "🍤", "🥗", "🥫"]
    static let emojiVehicle = ["🚃", "🚄", "🚅", "🚆", "🚇", "🚈", "🚉", "🚊", "🚝", "🚞",
                        "🚋", "🚌", "🚍", "🚎", "🚐", "🚑", "🚒", "🚓", "🚔", "🚕",
                        "🚖", "🚗", "🚘", "🚙", "🛻", "🚚", "🚛"]
    
    @Published private var model = MemoryGame(numberOfPairsCards: 4) { pairIndex in
        emojiFood[pairIndex]
    }
    
    var cards: [MemoryGame<String>.Card]{
        return self.model.cards
    }
    
    // MARK: - choose
    func choose(_ card: MemoryGame<String>.Card){
        self.model.choose(card)
    }
}
