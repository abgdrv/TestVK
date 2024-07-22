//
//  LocalizableKeys.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

enum LocalizableKeys: String {
    case appName = "app_name"
    case language
    
    enum WeatherEvent: String {
        case clear = "weather_clear"
        case rain = "weather_rain"
        case thunderstorm = "weather_thunderstorm"
        case fog = "weather_fog"
        case snow = "weather_snow"
        case cloudy = "weather_cloudy"
        case partlyCloudy = "weather_partly_cloudy"
    }
}

extension RawRepresentable where RawValue == String {
    var localized: String {
        return rawValue.localized
    }
}
