//
//  UserSettings.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 29.10.2020.
//

import Foundation

private enum UserDefaultsKeys: String {
    case userLocal
}

extension UserDefaults {
    
    // MARK: Check field
    func isSet(_ key: String) -> Bool {
        return object(forKey: key) != nil
    }
    
    // MARK: SET user fields in memory
    func setUserLocale(locale: String) { set(locale, forKey: UserDefaultsKeys.userLocal.rawValue) }
    
    // MARK: REMOVE user fields in memory
    func removeUserLocale() { removeObject(forKey: UserDefaultsKeys.userLocal.rawValue) }
    
    // MARK: GET user fields in memory
    
    func getUserLocale() -> String {
        let lang = Bundle.main.preferredLocalizations.first
        return isSet(UserDefaultsKeys.userLocal.rawValue) ?
            string(forKey: UserDefaultsKeys.userLocal.rawValue)! :
            Language.languageByCode(code: lang != nil ? lang! : Language.English.code()).code()
    }
   
}
