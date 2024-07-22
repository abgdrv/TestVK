//
//  Images.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

enum Images: String, ImagesProtocol {
    case appIcon = "AppIcon"
    
    enum WeatherEvent: String, ImagesProtocol {
        case clear
        case cloudy
        case partlyCloudy = "partly_cloudy"
        case rain
        case snow
        case thunderstorm
        
        case particle
        case cloud
    }
}
