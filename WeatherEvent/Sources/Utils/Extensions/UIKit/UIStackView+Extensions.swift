//
//  UIStackView+Extensions.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

extension UIStackView {
    
    convenience init(
        views: [UIView],
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: Distribution = .fill,
        alignment: Alignment = .fill,
        spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }

    func addArrangedSubviews(_ views: UIView...) {
        addArrangedSubviews(views)
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview(_:))
    }
}
