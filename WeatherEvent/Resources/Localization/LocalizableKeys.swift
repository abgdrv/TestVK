//
//  LocalizableKeys.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

enum LocalizableKeys: String {
    case appName = "app_name"
}

extension RawRepresentable where RawValue == String {
    var localized: String {
        return rawValue.localized
    }
}
