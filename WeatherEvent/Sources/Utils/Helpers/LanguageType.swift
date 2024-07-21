//
//  LanguageType.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

enum LanguageType: String {
    case ru = "ru"
    case en = "en"
}

extension LanguageType {

    var locale: Locale {
        switch self {
        case .ru:
            return Locale(identifier: "ru_RU")
        case .en:
            return Locale(identifier: "en_US")
        }
    }
}
