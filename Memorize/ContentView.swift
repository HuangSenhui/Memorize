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
        HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .onTapGesture {
                        self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}


struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    let cornerRadius: CGFloat = 10.0
    let borderWidth: CGFloat = 3.0
    
    var body: some View {
        
        GeometryReader { geometry in
            self.body(of: geometry.size)

        }
        
    }
    
    func body(of size: CGSize) -> some View {
        ZStack {
            if self.card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: borderWidth)
                
                Text(self.card.content)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill()
            }
            
        }
        .font(fontSize(size: size))
    }
    
    //
    func fontSize(size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * 0.8)
    }
}
