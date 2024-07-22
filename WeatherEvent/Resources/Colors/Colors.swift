//
//  Colors.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

enum Colors: String, ColorsProtocol {
    
    case mainBackground = "main_background"
    case mainTitle = "main_title"
    case grayTitle = "gray_title"
    
    enum Gradient: String, ColorsProtocol {
        case snow1
        case snow2
        
        case thunder1
        case thunder2
        
        case rain1
        case rain2
        
        case clear1
        case clear2
        
        case cloudy1
        case cloudy2
    }
}
