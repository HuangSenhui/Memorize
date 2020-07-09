//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/5.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//

import SwiftUI  // ViewModel


class EmojiMemoryGame: ObservableObject {
    
    // private(set): 只能访问，不能修改
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🐶"]
//        return MemoryGame(numberOfPaireOfCards: emojis.count) { (index) -> String in
//            return emojis[index]
//        }
        // 同上
        return MemoryGame(numberOfPaireOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: Access Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = Self.createMemoryGame()
    }
}
