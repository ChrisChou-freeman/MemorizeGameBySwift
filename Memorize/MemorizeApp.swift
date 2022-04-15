//
//  MemorizeApp.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject private var game = MemoryGameHandler()
    
    var body: some Scene {
        WindowGroup {
            GameList()
                .environmentObject(game)
        }
    }
}
