//
//  DModels.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import Foundation

struct DRates {
    let symbol: String
    let name: String
    let rate: Double
}

extension TRatesBundle {
    func toRates() -> [DRates] {
        return symbols.symbols.map { DRates(symbol: $0.key, name: $0.value, rate: rates.rates[$0.key] ?? 0.0) }
    }
    
}
