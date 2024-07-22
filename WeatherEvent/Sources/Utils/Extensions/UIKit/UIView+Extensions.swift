//
//  UIView+Extensions.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}

extension UIView {
    
    func constraint(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        insets: UIEdgeInsets = .zero
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        if let top = top {
            constraints.append(self.topAnchor.constraint(equalTo: top, constant: insets.top))
        }
        
        if let leading = leading {
            constraints.append(self.leadingAnchor.constraint(equalTo: leading, constant: insets.left))
        }
        
        if let bottom = bottom {
            constraints.append(self.bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom))
        }
        
        if let trailing = trailing {
            constraints.append(self.trailingAnchor.constraint(equalTo: trailing, constant: -insets.right))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func matchSuperview(withInsets insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
        ])
    }
    
    func centerInSuperview() {
        centerXInSuperview()
        centerYInSuperview()
    }
    
    func centerXInSuperview() {
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        ])
    }
    
    func centerYInSuperview() {
        guard let superview = self.superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
    
    func centerX(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func centerY(in view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setSize(width: CGFloat, height: CGFloat) {
        setWidth(width)
        setHeight(height)
    }
    
    func setWidth(_ width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    func setHeight(_ height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}

extension UIView {
    
    func shake(duration: CFTimeInterval = 1.0, repeatCount: Float = .infinity) {
        self.layer.removeAnimation(forKey: "shakeIt")
        
        let translation = CABasicAnimation(keyPath: "transform.translation.x")
        translation.fromValue = -10
        translation.toValue = 10
        translation.autoreverses = true
        translation.duration = duration / 2
        translation.repeatCount = .infinity
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = -Double.pi / 64
        rotation.toValue = Double.pi / 64
        rotation.autoreverses = true
        rotation.duration = duration / 2
        rotation.repeatCount = .infinity
        
        let shakeGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        shakeGroup.repeatCount = repeatCount
        shakeGroup.timingFunction = CAMediaTimingFunction(name: .linear)
        
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
}
