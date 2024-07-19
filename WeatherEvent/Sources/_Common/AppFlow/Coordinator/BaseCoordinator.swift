//
//  BaseCoordinator.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    init() {}
    
    func start() {}
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator else { return }
        
        if let baseCoordinator = coordinator as? BaseCoordinator, !baseCoordinator.childCoordinators.isEmpty {
            baseCoordinator.childCoordinators
                .filter({ $0 !== baseCoordinator })
                .forEach({ baseCoordinator.removeDependency($0) })
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
