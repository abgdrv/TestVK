//
//  CoordinatorFactory.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import UIKit

final class CoordinatorFactory: CoordinatorFactoryProtocol {
    
    private let factory = FlowFactory()
    
    func makeSplashScreenCoordinator(router: Routable) -> Coordinator & SplashScreenOutputCoordinator {
        let coordinator = SplashScreenCoordinator(router: router, factory: factory)
        return coordinator
    }
}

private extension CoordinatorFactory {
    
    func router(_ navController: UINavigationController?) -> Router {
        return Router(rootController: navigationController(navController))
    }
    
    func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController }
        else { return UINavigationController() }
    }
}
