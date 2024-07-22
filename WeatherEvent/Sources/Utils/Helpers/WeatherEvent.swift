//
//  WeatherEvent.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

enum WeatherEvent: CaseIterable {
    case clear
    case cloudy
    case partlyCloudy
    case rain
    case thunderstorm
    case snow
    
    var title: String {
        switch self {
        case .clear:
            return LocalizableKeys.WeatherEvent.clear.localized
        case .rain:
            return LocalizableKeys.WeatherEvent.rain.localized
        case .thunderstorm:
            return LocalizableKeys.WeatherEvent.thunderstorm.localized
        case .snow:
            return LocalizableKeys.WeatherEvent.snow.localized
        case .cloudy:
            return LocalizableKeys.WeatherEvent.cloudy.localized
        case .partlyCloudy:
            return LocalizableKeys.WeatherEvent.partlyCloudy.localized
        }
    }
    
    var colors: (UIColor, UIColor?, UIColor) {
        switch self {
        case .snow:
            return (Colors.Gradient.snow1.uiColor, nil, Colors.Gradient.snow2.uiColor)
        case .thunderstorm:
            return (Colors.Gradient.thunder1.uiColor, nil, Colors.Gradient.thunder2.uiColor)
        case .rain:
            return (Colors.Gradient.rain1.uiColor, nil, Colors.Gradient.rain2.uiColor)
        case .clear:
            return (Colors.Gradient.clear1.uiColor, Colors.Gradient.clear1.uiColor, Colors.Gradient.snow1.uiColor)
        case .cloudy:
            return (Colors.Gradient.cloudy1.uiColor, nil, Colors.Gradient.cloudy2.uiColor)
        case .partlyCloudy:
            return (Colors.Gradient.clear1.uiColor, Colors.Gradient.snow1.uiColor, Colors.Gradient.snow1.uiColor)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .clear:
            return Images.WeatherEvent.clear.uiImage
        case .rain:
            return Images.WeatherEvent.rain.uiImage
        case .thunderstorm:
            return Images.WeatherEvent.thunderstorm.uiImage
        case .snow:
            return Images.WeatherEvent.snow.uiImage
        case .cloudy:
            return Images.WeatherEvent.cloudy.uiImage
        case .partlyCloudy:
            return Images.WeatherEvent.partlyCloudy.uiImage
        }
    }
    
    var animationImage: UIImage? {
        switch self {
        case .clear, .snow, .rain:
            return Images.WeatherEvent.particle.uiImage
        case .cloudy, .partlyCloudy:
            return Images.WeatherEvent.cloud.uiImage
        default:
            return nil
        }
    }
}
