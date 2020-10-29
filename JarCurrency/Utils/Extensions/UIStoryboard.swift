//
//  UIStoryboard.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 29.10.2020.
//

import UIKit

fileprivate enum StoryboardName {
    case settings
    
    var rawValue: (name: String, identifier: String) {
        switch self {
            case .settings: return ("SettingsView", "SettingsView")
        }
    }
}

fileprivate extension UIStoryboard {
    class func load(_ storyboard: StoryboardName) -> UIViewController {
        return UIStoryboard(name: storyboard.rawValue.name, bundle: nil).instantiateViewController(withIdentifier: storyboard.rawValue.identifier)
    }
}

extension UIStoryboard {
    class func loadSettingsView() -> SettingsViewController {
        return UIStoryboard.load(.settings) as! SettingsViewController
    }
}
