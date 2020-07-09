//
//  Cardify.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/7.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: borderWidth)
                content // 代表被修饰容器的内容
            }
            .opacity(isFaceUp ? 1 : 0)
           
            RoundedRectangle(cornerRadius: cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1)

        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0,1,0))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let borderWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
