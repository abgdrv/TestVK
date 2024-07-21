//
//  FlowFactory.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import Foundation

final class FlowFactory: SplashScreenFlowFactory {
    
    func makeSpashScreen() -> SplashScreenView {
        let vc = SplashScreenViewController()
        return vc
    }
}
