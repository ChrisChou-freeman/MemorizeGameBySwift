//
//  MemoryGameHandler.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/21.
//

import SwiftUI


class MemoryGameHandler: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    @Published var emojiDatas: [EmojiData]{
        didSet{
            saveStructsToFile(emojiDatas, to: "Emojis.json")
        }
    }
    @Published private var model = MemoryGame<String>(numberOfPairsCards: 10)
    
    init(){
        self.emojiDatas = loadJsonToStruct("Emojis.json")
    }
    
    var cards: [Card]{
        return self.model.cards
    }
    
    var score: Int{
        return self.model.score
    }
    
    func start(with theme: String){
        let emojidata = emojiDatas.first{
            $0.theme == theme
        }!
        if emojidata.datas.isEmpty{
            return
        }
        self.model.loadCards(cardContents: emojidata.datas, color: emojidata.color)
    }
    
    func addGameList(){
        emojiDatas.append(
            EmojiData(
                id: emojiDatas.count + Int.random(in: 1...10000),
                theme: "empty",
                datas: [],
                cardPairs: 0,
                color: .wihte
            )
        )
    }
    
    // MARK: - choose
    func choose(_ card: Card){
        self.model.choose(card)
    }
    
    func shuffle(){
        self.model.shuffle()
    }
    
    func restart(with theme: String){
        self.model = MemoryGame<String>(numberOfPairsCards: 10)
        self.start(with: theme)
    }
}
