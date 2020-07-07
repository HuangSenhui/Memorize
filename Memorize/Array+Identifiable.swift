//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by HuangSenhui on 2020/7/6.
//  Copyright © 2020 HuangSenhui. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        for (index, value) in self.enumerated() {
            if matching.id == value.id {
                return index
            }
        }
        return nil
    }
}
