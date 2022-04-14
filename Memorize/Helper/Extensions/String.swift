//
//  String.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/14.
//

import Foundation

extension String{
    func convertHexStringToInt() -> Int {
        return Int(self, radix: 16) ?? 0
    }
}
