//
//  MemoryGame.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/5.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//

import Foundation   // Model

struct MemoryGame<CardContent> {
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent    // 卡片显示内容：可以是字符、数字、图片... 所以使用泛型（don't care type）
    }
    
    var cards: Array<Card>
    
    /// 构造器
    /// - Parameters:
    ///   - numberOfPaireOfCards: 几组卡片
    ///   - cardContentFactory: 对应卡片的类型
    init(numberOfPaireOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for index in 0..<numberOfPaireOfCards {
            let content = cardContentFactory(index)
            cards.append(Card(id: index*2, content: content))
            cards.append(Card(id: index*2+1, content: content))
        }
    }
    
    mutating func choose(card: Card) {
        print("choosen card: \(card)")
        let index = self.index(of: card)
        self.cards[index].isFaceUp = !self.cards[index].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for (index, item) in cards.enumerated() {
            if card.id == item.id {
                return index
            }
        }
        return 0
    }
}
