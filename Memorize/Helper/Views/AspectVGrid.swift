//
//  AspectVGrid.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/25.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: Array<Item>
    var aspectRation: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRation: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRation = aspectRation
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                let width: CGFloat = self.widthThatFits(
                    itemCount: self.items.count,
                    in: geometry.size,
                    itemAspectRatio: self.aspectRation
                )
                LazyVGrid(columns: [self.adaptiveGridItem(width: width)], spacing: 0){
                    ForEach(self.items){ item in
                        self.content(item).aspectRatio(self.aspectRation, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem{
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat{
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
        if columnCount > itemCount {
            columnCount = itemCount
        }
        let result = floor(size.width / CGFloat(columnCount))
        return result
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
