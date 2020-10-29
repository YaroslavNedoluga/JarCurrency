//
//  LanguageManager.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 29.10.2020.
//

import Foundation

class LanguageManager: NSObject {
    
    static func getTranslationForKey(_ key: String, lang: String? = nil) -> String {
        let langCode = lang ?? UserDefaults.standard.getUserLocale()
        let bundlePath = Bundle.main.path(forResource: langCode, ofType: "lproj")!
        let languageBundle = Bundle(path: bundlePath)
        
        let translatedString = languageBundle?.localizedString(forKey: key, value: "", table: nil)

        if translatedString == nil {
           return NSLocalizedString(key, tableName: nil, bundle: Bundle.main, value: key, comment: key)
        } else {
            return translatedString!
        }
    }

}

enum Language: String {
    case English = "English"
    case Russian = "Русский"
    
    static func languageByCode(code: String) -> Language {
        switch code {
        case "ru":
            return .Russian
        default:
            return .English
        }
    }
    
    func code() -> String {
        var flagImageName: String!
        switch self {
        case .English:
            flagImageName = "en"
        case .Russian:
            flagImageName = "ru"
        }
        
        return flagImageName
    }
}

func CustomLocalisedString(_ key: String) -> String {
    return LanguageManager.getTranslationForKey(key)
}

func CustomLocalisedStringByLang(_ key: String, lang: String) -> String {
    return LanguageManager.getTranslationForKey(key, lang: lang)
}

