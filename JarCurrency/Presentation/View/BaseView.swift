//
//  BaseView.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import UIKit
import Swinject

class BaseViewController: UIViewController {
    var diAssembler: DIAssembler = (UIApplication.shared.delegate as? AppDelegate)!.diAssembler
}
