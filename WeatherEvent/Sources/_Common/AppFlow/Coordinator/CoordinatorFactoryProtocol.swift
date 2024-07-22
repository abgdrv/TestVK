//
//  CoordinatorFactoryProtocol.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import Foundation

protocol CoordinatorFactoryProtocol {
    func makeSplashScreenCoordinator(router: Routable) -> Coordinator & SplashScreenOutputCoordinator
    func makeMainScreenCoordinator(router: Routable) -> Coordinator & MainScreenOutputCoordinator
}
