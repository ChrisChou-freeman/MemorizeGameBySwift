//
//  EmojiData.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import Foundation


struct EmojiData: Hashable, Codable, Identifiable{
    var id: Int
    var theme: String
    var datas: [String]
    var cardPairs: Int
    var color: EmojiColor
    
    enum EmojiColor: String, Codable, Equatable, CaseIterable{
        case red = "ff2400"
        case green = "32cd32"
        case blue = "5b92e5"
        case wihte = "FFFFFF"
    }
}
