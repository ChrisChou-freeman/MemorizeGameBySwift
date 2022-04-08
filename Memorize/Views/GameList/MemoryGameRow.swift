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
        HStack{
            Text(emoji.theme.rawValue)
            Text(datasSubList.joined())
        }
        .padding(.vertical, 4)
    }
    
    var datasSubList: [String]{
        Array(emoji.datas[...10])
    }
}

struct MemoryGameRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameRow(emoji: MemoryGameHandler.emojiDatas[0])
    }
}
