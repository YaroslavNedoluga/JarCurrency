//
//  ExDate.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

extension TimeInterval {
    init(hours: Int){
        self = TimeInterval(3600 * hours)
    }
}

