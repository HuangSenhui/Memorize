//
//  ContentView.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/5.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card)
                .onTapGesture {
                    self.viewModel.choose(card: card)   // why use `self.`? 闭包是引用类型，viewModel也是引用类型
            }
            .padding(5)
        }
        .padding()
        .foregroundColor(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = EmojiMemoryGame()
        vm.choose(card: vm.cards[0])
        return ContentView(viewModel: vm)
    }
}


struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    var body: some View {
        
        GeometryReader { geometry in
            self.body(of: geometry.size)
            
        }
        
    }
    
    private func body(of size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    // iOS 坐标原点在左上角
                    // 角度0 水平右侧
                    Pie(
                        startAngle: Angle.degrees(-90),
                        endAngle: Angle.degrees(120-90),
                        clockwise: true
                    )
                        .opacity(0.5)
                        .padding(5)
                    
                    Text(card.content)
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
            
        }
        .font(fontSize(size: size))
    }
    
    //
    private func fontSize(size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.7)
    }
}
