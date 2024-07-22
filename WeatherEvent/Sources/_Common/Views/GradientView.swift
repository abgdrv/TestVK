//
//  GradientView.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

final class GradientView: UIView {
    
    private var startColor: UIColor = .clear
    private var midColor: UIColor?
    private var endColor: UIColor = .clear
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let layer = layer as? CAGradientLayer {
            if let midColor = midColor {
                layer.colors = [startColor.cgColor, midColor.cgColor, endColor.cgColor]
            } else {
                layer.colors = [startColor.cgColor, endColor.cgColor]
            }
        }
    }
    
    func setColors(startColor: UIColor, midColor: UIColor? = nil, endColor: UIColor) {
        self.startColor = startColor
        self.midColor = midColor
        self.endColor = endColor
    }
}
