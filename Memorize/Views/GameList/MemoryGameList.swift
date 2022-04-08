//
//  MemoryGameList.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI

struct MemoryGameList: View {
    var body: some View {
        NavigationView{
            List{
                ForEach(MemoryGameHandler.emojiDatas){ emoji in
                    NavigationLink{
                        EmojiMemoryGameView(
                            emojiGame: MemoryGameHandler(with: emoji.theme),
                            theme: emoji.theme
                        )
                    } label: {
                        MemoryGameRow(emoji: emoji)
                    }
                    .tag(emoji)
                }
            }
            .navigationTitle("Game List")
            Text("Select a Game")
        }
    }
}

struct MemoryGameList_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameList()
    }
}
