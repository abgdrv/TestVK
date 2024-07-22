//
//  FlowFactory.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import Foundation

final class FlowFactory: SplashScreenFlowFactory, MainScreenFlowFactory {
    
    func makeSpashScreen() -> SplashScreenView {
        let vc = SplashScreenViewController()
        return vc
    }
    
    func makeMainScreen() -> MainScreenView {
        let vm = MainScreenViewModel()
        let vc = MainScreenViewController(viewModel: vm)
        return vc
    }
}
