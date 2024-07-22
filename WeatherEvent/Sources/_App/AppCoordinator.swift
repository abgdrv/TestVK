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
            self?.runMainFlow()
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
    
    func runMainFlow() {
        var coordinator = coordinatorFactory.makeMainScreenCoordinator(router: router)
        
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            // Transition to another view
        }
        
        coordinator.languageChanged = { [weak self] in
            self?.runMainFlow()
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
}
