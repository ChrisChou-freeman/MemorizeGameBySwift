//
//  MemoryGameHandler.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import SwiftUI


class MemoryGameHandler: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojiDatas: [EmojiData] = loadJsonToStruct("Emojis.json")
    @Published private var model: MemoryGame<String>
    
    var cards: [Card]{
        return self.model.cards
    }
    
    var score: Int{
        return self.model.score
    }
    
    init(with theme: EmojiData.EmojiTheme){
        self.model = MemoryGameHandler.createMemryGame(with: theme)
    }
    
    private static func getEmojis(with theme: EmojiData.EmojiTheme) -> [String] {
        let datas = emojiDatas.first{
            $0.theme == theme
        }?.datas
        return datas!
    }
    
    private static func createMemryGame(with theme: EmojiData.EmojiTheme) -> MemoryGame<String>{
        let datas = getEmojis(with: theme)
        return MemoryGame(numberOfPairsCards: 10) { pairIndex in
            datas[pairIndex]
        }
    }
    
    // MARK: - choose
    func choose(_ card: Card){
        self.model.choose(card)
    }
    
    func shuffle(){
        self.model.shuffle()
    }
    
    func restart(with theme: EmojiData.EmojiTheme){
        self.model = MemoryGameHandler.createMemryGame(with: theme)
    }
}
