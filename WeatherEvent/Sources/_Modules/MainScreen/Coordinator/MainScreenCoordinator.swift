//
//  MainScreenCoordinator.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import Foundation

protocol MainScreenOutputCoordinator {
    var finishFlow: VoidCallback? { get set }
    var languageChanged: VoidCallback? { get set }
}

final class MainScreenCoordinator: BaseCoordinator, MainScreenOutputCoordinator {
    
    var finishFlow: VoidCallback?
    var languageChanged: VoidCallback?
    
    private let router: Routable
    private let factory: MainScreenFlowFactory
    
    init(router: Routable, factory: MainScreenFlowFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showMainScreen()
    }
}

private extension MainScreenCoordinator {
    
    func showMainScreen() {
        let view = factory.makeMainScreen()
        
        view.didFinish = { [weak self] in
            self?.finishFlow?()
        }
        
        view.didChangeLanguage = { [weak self] in
            self?.languageChanged?()
        }
        
        router.setRootModule(view)
    }
}
