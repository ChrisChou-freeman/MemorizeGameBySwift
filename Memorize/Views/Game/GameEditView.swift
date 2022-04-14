//
//  GameEditView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/4/12.
//

import SwiftUI

struct GameEditView: View {
    @EnvironmentObject var game: MemoryGameHandler
    @Binding var isShowingSheet: Bool
    @State var text = "some"
    @State var number = 0
    var editIndex: Int
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("theme name")){
                    TextField("someInput", text: Binding<String>(
                        get: { game.emojiDatas[editIndex].theme },
                        set: { game.emojiDatas[editIndex].theme = $0 }
                    ))
                }
                Section(
                    header: HStack{
                        Text("emojis")
                        Spacer()
                        Text("tap emoji to exclude")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                ){
                    VStack{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 30.0))], spacing: 0){
                            ForEach(game.emojiDatas[editIndex].datas, id: \.self){ item in
                                Text(item)
                                    .font(.system(size: 40))
                            }
                        }
                    }
                }
                Section(header: Text("add emoji")){
                    EmojiTextField(text: Binding<String>(
                        get: { game.emojiDatas[editIndex].datas.joined() },
                        set: {
                            game.emojiDatas[editIndex].datas = $0.map{String($0)}
                        }
                    ))
                }
                Section(header: Text("card count")){
                    Stepper("\(game.emojiDatas[editIndex].cardPairs) pairs",
                            value: Binding(
                                get: {game.emojiDatas[editIndex].cardPairs},
                                set: {game.emojiDatas[editIndex].cardPairs = $0}
                            ),
                            in: 0...10
                    )
                }
                Section(header: Text("color")){
                    VStack{
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 0){
                            ForEach(EmojiData.EmojiColor.allCases, id: \.self){ item in
                                colorCard(width: 60, height: 80, to: item)
                            }
                        }
                        .frame(height: 100)
                    }
                }
            }
            .navigationTitle(game.emojiDatas[editIndex].theme)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        isShowingSheet.toggle()
                    }label: {
                        Text("Done")
                    }
                }
            }
        }
    }
    
    private func colorCard(width: CGFloat, height: CGFloat, to color: EmojiData.EmojiColor) -> some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 10)
            if color == .wihte{
//                shape.strokeBorder(lineWidth: 1).foregroundColor(.black)
                shape.fill(.white)
            }else{
                shape.fill().foregroundColor(
                    Color.colorFromHex(hex: color.rawValue.convertHexStringToInt())
                )
            }
            if game.emojiDatas[editIndex].color == color{
                Image(systemName: "checkmark.circle")
            }
        }
        .onTapGesture {
            if game.emojiDatas[editIndex].color != color{
                game.emojiDatas[editIndex].color = color
            }
        }
        .frame(width:width, height: height)
    }
}

struct GameEdit_Previews: PreviewProvider {
    @State static var someBool = false
    static var game = MemoryGameHandler()
    static var previews: some View {
        GameEditView(isShowingSheet: $someBool, editIndex: 0)
            .preferredColorScheme(.light)
            .environmentObject(game)
    }
}
