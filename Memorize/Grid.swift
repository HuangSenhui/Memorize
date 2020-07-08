//
//  Grid.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/6.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//  网格容器

import SwiftUI

struct Grid<Item, ViewForItem>: View where Item: Identifiable, ViewForItem: View {
    
    private var items: [Item]
    private var viewForItem: (Item) -> ViewForItem
    
    init(_ items: [Item], itemView: @escaping (Item) -> ViewForItem) {
        self.items = items
        self.viewForItem = itemView
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
    
    // 重复方法
    // 扩展Array
//    func index(of item: Item) -> Int {
//        for (index, value) in items.enumerated() {
//            if item.id == value.id {
//                return index
//            }
//        }
//        return 0 // bogus
//    }
}


