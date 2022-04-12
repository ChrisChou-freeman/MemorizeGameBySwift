//
//  MemoryGameList.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI

struct MemoryGameList: View {
    @EnvironmentObject var game: MemoryGameHandler
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationView{
            List{
                ForEach(game.emojiDatas){ emoji in
                    NavigationLink{
                        GameView(
                            theme: emoji.theme
                        )
                    } label: {
                        MemoryGameRow(emoji: emoji)
                    }
                }
                .onDelete(perform: { index in
                    self.game.emojiDatas.remove(atOffsets: index)
                })
            }
            .toolbar{
                plusGameButton
                editGameButton
            }
            .navigationTitle("Game List")
            Text("Select a Game")
        }
    }
    
    var plusGameButton: some ToolbarContent{
        ToolbarItem{
            Button{
                game.addGameList()
            }label: {
                Label("Add Game", systemImage: "plus")
            }
        }
    }
    
    var editGameButton: some ToolbarContent{
        ToolbarItem(placement: .navigationBarLeading){
            EditButton()
        }
    }
}


struct MemoryGameList_Previews: PreviewProvider {
    static var game = MemoryGameHandler()
    static var previews: some View {
        MemoryGameList()
            .environmentObject(game)
    }
}
