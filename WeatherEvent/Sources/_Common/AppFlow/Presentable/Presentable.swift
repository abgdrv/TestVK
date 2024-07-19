//
//  Presentable.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
