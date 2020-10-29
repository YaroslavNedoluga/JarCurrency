//
//  ExString.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation

extension String {
    
    func toData() -> Data {
        return self.data(using: String.Encoding.utf8)!
    }

    func toLocalizable() -> String {
        return CustomLocalisedString(self)
    }
}
