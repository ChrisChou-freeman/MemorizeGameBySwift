//
//  GameList.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/8.
//

import SwiftUI

struct GameList: View {
    @EnvironmentObject var game: MemoryGameHandler
    @State private var editMode: EditMode = EditMode.inactive
    @State private var showEditView = false
    @State private var editIndex: Int = 0
    
    var body: some View {
        NavigationView{
            List{
                ForEach(game.emojiDatas){ emoji in
                    NavigationLink{
                        GameView(
                            theme: emoji.theme
                        )
                    } label: {
                        ListRow(emoji: emoji)
                    }
                    .gesture(
                        editMode == .active ? editTap(
                            for: game.emojiDatas.firstIndex(of: emoji)
                        ) : nil
                    )
                }
                .onDelete(perform: { index in
                    self.game.emojiDatas.remove(atOffsets: index)
                })
            }
            .environment(\.editMode, $editMode)
            .toolbar{
                plusGameButton
                editGameButton
            }
            .sheet(isPresented: $showEditView){
                ListEditView(isShowingSheet: $showEditView, editIndex: 0)
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
            Button{
                let nowEditMode = editMode
                withAnimation(){
                    editMode = nowEditMode == .inactive ? .active : .inactive
                }
            }label: {
                Group{
                    if editMode == .inactive{
                        Text("Edit")
                    }else{
                        Text("Done")
                    }
                }
            }
        }
    }
    
    func editTap(for editIndex: Int?) -> some Gesture {
        TapGesture().onEnded{
            print("tap")
            self.editIndex = editIndex!
            showEditView.toggle()
        }
    }
}


struct MemoryGameList_Previews: PreviewProvider {
    static var game = MemoryGameHandler()
    static var previews: some View {
        GameList()
            .preferredColorScheme(.dark)
            .environmentObject(game)
    }
}
