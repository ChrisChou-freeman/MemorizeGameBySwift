//
//  MemoryGameRow.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI

struct MemoryGameRow: View {
    var emoji: EmojiData
    
    var body: some View {
        VStack(alignment:.leading){
            Text(emoji.theme)
                .bold()
                .font(.title2)
            Text(emoji.datas.joined())
        }
        .padding(.vertical, 4)
    }
    
}

struct MemoryGameRow_Previews: PreviewProvider {
    static var game = MemoryGameHandler()
    static var previews: some View {
        MemoryGameRow(emoji: game.emojiDatas[0])
    }
}
