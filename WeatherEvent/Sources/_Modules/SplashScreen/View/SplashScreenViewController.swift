//
//  SplashScreenViewController.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import UIKit

final class SplashScreenViewController: BaseViewController, SplashScreenView {
    
    var didFinish: VoidCallback?
    
    private let textAnimation = 3.0
    private let overlapAnimation = 0.5
    
    private let generator = UIImpactFeedbackGenerator(style: .soft)
    
    private lazy var circleView: UIView = build {
        $0.backgroundColor = Colors.mainTitle.uiColor
        $0.layer.cornerRadius = 50 // Assuming the initial size is 100x100
        $0.alpha = 0
        $0.transform = CGAffineTransform(scaleX: 0, y: 0)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var logoImageView: UIImageView = build {
        $0.image = Images.appIcon.uiImage
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var titleLabel: UILabel = build {
        $0.set(font: .systemFont(ofSize: 24, weight: .semibold), textColor: Colors.mainTitle.uiColor, textAlignment: .center)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [logoImageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        startAnimation()
    }
}

private extension SplashScreenViewController {
    
    func setupViews() {
        view.addSubviews(circleView, containerStackView)
        view.bringSubviewToFront(circleView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 100),
            circleView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

private extension SplashScreenViewController {
    
    func startAnimation() {
        titleLabel.setTyping(text: LocalizableKeys.appName.localized, characterDelay: textAnimation) { [weak self] in
            self?.generator.prepare()
            self?.generator.impactOccurred()
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
            self.circleView.transform = CGAffineTransform(scaleX: maxScaleEffect, y: maxScaleEffect)
            self.circleView.alpha = 1
        }, completion: nil)
    }
}
