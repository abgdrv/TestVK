//
//  Routable.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import UIKit

protocol Routable: Presentable {
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    func present(_ module: Presentable?, transitionStyle: UIModalTransitionStyle)
    func present(_ module: Presentable?, presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, hideBottomBar: Bool)
    func push(_ module: Presentable?, animated: Bool, hideNavBar: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: VoidCallback?)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, hideNavBar: Bool, completion: VoidCallback?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismiss(_ module: Presentable?)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: VoidCallback?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideNavBar: Bool)
    
    func popToRootModule()
    func popToRootModule(animated: Bool)
}
