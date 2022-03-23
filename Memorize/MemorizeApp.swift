//
//  MemorizeApp.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup { 
            ContentView(emojiGameModel: game)
        }
    }
}
