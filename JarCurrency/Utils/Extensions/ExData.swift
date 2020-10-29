//
//  ExData.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation

extension Data {
    
    func toString() -> String {
        return String(data: self, encoding: .utf8)!
    }
}
