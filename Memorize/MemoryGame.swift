//
//  MemoryGame.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/5.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//  1. 翻转第一张卡片，是否已翻转
//  2. 翻转第二张卡片，相同消失
//  3. 翻转第三张卡片，前两张翻转回去

import Foundation   // Model

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent    // 卡片显示内容：可以是字符、数字、图片... 所以使用泛型（don't care type）
    }
    
    var cards: Array<Card>
    // 这里老师展示了可选性的巧妙用法
    var indexOfTheOneAndOnlyFaceUp: Int? {
        get {
            let faceupIndices = cards.indices.filter { cards[$0].isFaceUp } // 已翻转的
            if faceupIndices.count == 1 {   // 有2张以上的牌时，清空已翻转，并在set方法执行时
                return faceupIndices.first
            } else {
                return nil
            }
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue   //
            }
        }
    }
    
    
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
        // 翻转第一张牌：indexOfTheOneAndOnlyFaceUp
        // 翻转第二张牌：比较是否与第一张匹配indexOfTheOneAndOnlyFaceUp
        // 翻转第三张牌：如果有两张牌已翻转，则复位这两张，只翻转选中的
        if let index = cards.firstIndex(matching: card), !cards[index].isFaceUp, !cards[index].isMatched {
            // 执行indexOfTheOneAndOnlyFaceUp的get方法
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUp {
                if cards[index].content == cards[potentialMatchIndex].content {
                    cards[index].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUp = index
            }
        }
    }
    
//    func index(of card: Card) -> Int {
//        for (index, item) in cards.enumerated() {
//            if card.id == item.id {
//                return index
//            }
//        }
//        return 0
//    }
}
