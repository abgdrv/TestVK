//
//  MainScreenView.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import Foundation

protocol MainScreenView: BaseView {
    var didFinish: VoidCallback? { get set }
    var didChangeLanguage: VoidCallback? { get set }
}
