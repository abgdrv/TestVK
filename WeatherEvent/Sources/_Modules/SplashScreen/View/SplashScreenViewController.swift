//
//  SplashScreenViewController.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import UIKit

final class SplashScreenViewController: BaseViewController, SplashScreenView {
    
    var didFinish: VoidCallback?
    
    private let textAnimation = 2.0
    private let overlapAnimation = 0.5
        
    private lazy var overlapView = UIView().apply {
        $0.backgroundColor = Colors.Gradient.snow1.uiColor
        $0.layer.cornerRadius = 50
        $0.alpha = 0
        $0.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    private lazy var logoImageView = UIImageView(image: Images.appIcon.uiImage).apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: .systemFont(ofSize: 24, weight: .semibold), textColor: Colors.mainTitle.uiColor, textAlignment: .center)
    }
    
    private lazy var containerStackView = UIStackView(
        views: [logoImageView, titleLabel],
        alignment: .center,
        spacing: 16
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        startAnimation()
    }
}

private extension SplashScreenViewController {
    
    func setupViews() {
        view.addSubviews(overlapView, containerStackView)
        view.bringSubviewToFront(overlapView)
    }
    
    func setupConstraints() {
        containerStackView.centerInSuperview()
        logoImageView.setSize(width: 100, height: 100)
        overlapView.centerInSuperview()
        overlapView.setSize(width: 100, height: 100)
    }
}

private extension SplashScreenViewController {
    
    func startAnimation() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        
        titleLabel.setTyping(text: LocalizableKeys.appName.localized, characterDelay: textAnimation) { [weak self] in
            guard let _ = self else { return }
            generator.prepare()
            generator.impactOccurred()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + textAnimation + overlapAnimation) {
            self.didFinish?()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + textAnimation) {
            self.animateOverlap()
        }
    }
    
    func animateOverlap() {
        let maxScaleEffect: CGFloat = 20.0
        
        UIView.animate(withDuration: overlapAnimation, delay: 0, options: .curveEaseInOut, animations: {
            self.overlapView.transform = CGAffineTransform(scaleX: maxScaleEffect, y: maxScaleEffect)
            self.overlapView.alpha = 1
        }, completion: nil)
    }
}
