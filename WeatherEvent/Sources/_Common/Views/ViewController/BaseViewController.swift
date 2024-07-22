//
//  BaseViewController.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("💀: View Controller \(self) deinited")
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) is not available")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if #available(iOS 14.0, *) {
            navigationItem.backButtonDisplayMode = .minimal
        } else {
            navigationItem.backButtonTitle = nil
        }
    }
}

private extension BaseViewController {
    
    func setupViews() {
        view.backgroundColor = Colors.mainBackground.uiColor
    }
}
