//
//  ImagesProtocol.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import UIKit

protocol ImagesProtocol {
    var rawValue: String { get }
}

extension ImagesProtocol {
    
    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
}
