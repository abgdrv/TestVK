//
//  SplashScreenView.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

protocol SplashScreenView: BaseView {
    var didFinish: VoidCallback? { get set }
}
