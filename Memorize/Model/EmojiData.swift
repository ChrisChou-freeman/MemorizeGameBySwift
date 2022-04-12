//
//  EmojiData.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import Foundation


struct EmojiData: Hashable, Codable, Identifiable{
    var id: Int
    var theme: EmojiTheme
    var datas: [String]
    
    enum EmojiTheme: String, Codable, Equatable{
        case vehicle
        case food
        case empty
    }
}
