//
//  MemorizeApp.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/19.
//

import SwiftUI

@main
struct MemorizeApp: App {
    init(){
        // turn off fuck annoying logs
        UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
    }
    var body: some Scene {
        WindowGroup {
            MemoryGameList()
        }
    }
}
