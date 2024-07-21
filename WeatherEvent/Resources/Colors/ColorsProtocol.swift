//
//  ColorsProtocol.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import UIKit

protocol ColorsProtocol {
    var rawValue: String { get }
}

extension ColorsProtocol {
    
    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }
    
    var cgColor: CGColor {
        return uiColor.cgColor
    }
}
