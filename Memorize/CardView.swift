//
//  CardView.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/20.
//

import SwiftUI

struct CardView: View{
    let card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if self.card.isFaceUp{
                shape.foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(self.card.content).font(.largeTitle)
            }else{
                shape
            }
        }
        .foregroundColor(.red)
    }
}


//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: MemoryGame(4)){
//
//        }
//    }
//}
