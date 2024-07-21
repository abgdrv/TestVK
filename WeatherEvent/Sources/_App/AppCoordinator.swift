//
//  AppCoordinator.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

final class AppCoordinator: BaseCoordinator {
    
    private let router: Routable
    private let coordinatorFactory: CoordinatorFactoryProtocol
    
    init(router: Routable, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runSplashScreenFlow()
    }
}

private extension AppCoordinator {
    
    func runSplashScreenFlow() {
        var coordinator = coordinatorFactory.makeSplashScreenCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.runWeatherEventFlow()
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runWeatherEventFlow() {
        
    }
}
