//
//  AppDelegate.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 18.07.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UserDefaultsService.shared.removeObject(for: UserDefaultsKey.event.rawValue)
        
        appCoordinator = setupAppCoordinator()
        appCoordinator?.start()
        
        return true
    }
}

private extension AppDelegate {
    
    func setupAppCoordinator() -> AppCoordinator {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        let rootController = UINavigationController()
        self.window?.rootViewController = rootController
        
        let coordinator = AppCoordinator(
            router: Router(rootController: rootController),
            coordinatorFactory: CoordinatorFactory()
        )
        
        return coordinator
    }
}
