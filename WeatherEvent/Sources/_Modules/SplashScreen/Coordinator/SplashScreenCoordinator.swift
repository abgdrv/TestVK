//
//  SplashScreenCoordinator.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

final class SplashScreenCoordinator: BaseCoordinator, SplashScreenOutputCoordinator {
    
    var finishFlow: VoidCallback?
    
    private let router: Routable
    private let factory: SplashScreenFlowFactory
    
    init(router: Routable, factory: SplashScreenFlowFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showSplashScreen()
    }
}

private extension SplashScreenCoordinator {
    
    func showSplashScreen() {
        let view = factory.makeSpashScreen()
        
        view.didFinish = { [weak self] in
            self?.finishFlow?()
        }
        
        router.setRootModule(view, hideNavBar: true)
    }
}
