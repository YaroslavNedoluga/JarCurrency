//
//  CurrencyCell.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 29.10.2020.
//

import UIKit

final class CurrencyCell: UITableViewCell {
    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var lSubtitle: UILabel!
    @IBOutlet weak var lValue: UILabel!
    
    func set(_ rate: DRates, numberFormatter: NumberFormatter) {
        lTitle.text = rate.symbol
        lSubtitle.text = rate.name
        lValue.text = numberFormatter.string(from: NSNumber(value: rate.rate))
    }
}
