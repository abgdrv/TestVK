//
//  UserDefaultsService.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func set(value: Any?, for key: String)
    func value(for key: String) -> Any?
    func removeObject(for key: String)
}

enum UserDefaultsKey: String {
    case language
    case event
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    static let shared = UserDefaultsService()
    
    private init() {}
    
    var lang: LanguageType {
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: UserDefaultsKey.language.rawValue)
        }
        get {
            let storedLanguage = (UserDefaults.standard.value(forKey: UserDefaultsKey.language.rawValue) as? String) ?? LanguageType.ru.rawValue
            return LanguageType(rawValue: storedLanguage) ?? .ru
        }
    }
    
    func set(value: Any?, for key: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    func value(for key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    func removeObject(for key: String) {
        return UserDefaults.standard.removeObject(forKey: key)
    }
}
