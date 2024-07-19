//
//  Router.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 19.07.2024.
//

import UIKit

final class Router: Routable {
    
    private weak var rootController: UINavigationController?
    private var completions: [UIViewController: VoidCallback]
    private var presentedViewController: UIViewController?
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        
        if let presentedViewController = presentedViewController {
            presentedViewController.present(controller, animated: animated, completion: nil)
        } else {
            rootController?.present(controller, animated: animated, completion: nil)
        }
        
        presentedViewController = controller
    }
    
    func present(_ module: Presentable?, transitionStyle: UIModalTransitionStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = transitionStyle
        
        if let presentedViewController = presentedViewController {
            presentedViewController.present(controller, animated: true, completion: nil)
        } else {
            rootController?.present(controller, animated: true, completion: nil)
        }
        
        presentedViewController = controller
    }
    
    func present(_ module: Presentable?, presentationStyle: UIModalPresentationStyle, transitionStyle: UIModalTransitionStyle) {
        guard let controller = module?.toPresent() else { return }
        controller.modalPresentationStyle = presentationStyle
        controller.modalTransitionStyle = transitionStyle
        
        if let presentedViewController = presentedViewController {
            presentedViewController.present(controller, animated: true, completion: nil)
        } else {
            rootController?.present(controller, animated: true, completion: nil)
        }
        
        presentedViewController = controller
    }
    
    func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    func push(_ module: Presentable?, hideBottomBar: Bool) {
        push(module, animated: true, hideBottomBar: hideBottomBar, hideNavBar: false, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideNavBar: Bool) {
        push(module, animated: animated, hideBottomBar: false, hideNavBar: hideNavBar, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        push(module, animated: animated, hideBottomBar: false, hideNavBar: false, completion: completion)
    }
    
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, hideNavBar: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent(), (controller is UINavigationController == false) else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.isNavigationBarHidden = hideNavBar
        
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule() {
        popModule(animated: true)
    }
    
    func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func dismiss(_ module: Presentable?) {
        guard let controller = module?.toPresent() else { return }
        presentedViewController = controller.presentingViewController
        controller.dismiss(animated: true)
    }
    
    func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideNavBar: false)
    }
    
    func setRootModule(_ module: Presentable?, hideNavBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideNavBar
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.4
        
        if let window = UIApplication.shared.keyWindow {
            UIView.transition(with: window, duration: duration, options: options, animations: {})
        }
    }
    
    func popToRootModule() {
        popToRootModule(animated: true)
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach {
                runCompletion(for: $0)
            }
        }
    }
    
    func toPresent() -> UIViewController? {
        return rootController
    }
}

private extension Router {
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
