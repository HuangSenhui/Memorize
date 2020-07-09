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
        
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        withAnimation(.linear(duration: 1)) {
                            self.viewModel.choose(card: card)   // why use `self.`? 闭包是引用类型，viewModel也是引用类型
                            
                        }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(Color.yellow)
            
            Button(action: {
                withAnimation(.easeInOut) {
                    self.viewModel.resetGame()
                }
            }) {
                Text("新游戏")
            }
        }
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

    @State private var animatiedBounsRemaining: Double = 0
    
    private func startBounsAnimation() {
        animatiedBounsRemaining = card.bounsRemaining
        withAnimation(.linear(duration: card.bounsTimeRemaining)) {
            animatiedBounsRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(of size: CGSize) -> some View {
        

        if card.isFaceUp || !card.isMatched {
            ZStack {
            
                Group {
                    if card.customBounsTime {
                        // iOS 坐标原点在左上角
                        // 角度0 水平右侧
                        Pie(
                            startAngle: Angle.degrees(-90),
                            endAngle: Angle.degrees(-animatiedBounsRemaining * 360 - 90),    // 用 - 计时 * 360
                            clockwise: true
                        )
                            .onAppear {
                                self.startBounsAnimation()
                        }
                        
                    } else {
                        Pie(
                            startAngle: Angle.degrees(-90),
                            endAngle: Angle.degrees(-card.bounsRemaining * 360 - 90),    // 用 - 计时 * 360
                            clockwise: true
                        )
                    }
                    
                }
                .opacity(0.5)
                .padding(5)
                
                Text(card.content)
                    .font(fontSize(size: size))
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
        
    }
    
    //
    private func fontSize(size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.7)
    }
}
