//
//  AnimationView.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 22.07.2024.
//

import UIKit

protocol Animatable {
    func setupAnimation()
}

final class AnimationView: UIView, Animatable {
    
    private let eventType: WeatherEvent
    
    init(eventType: WeatherEvent) {
        self.eventType = eventType
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAnimation()
    }
    
    func setupAnimation() {
        guard let emitter = self.layer as? CAEmitterLayer else { return }
        
        switch eventType {
        case .snow:
            setupSnowAnimation(emitter: emitter)
        case .rain:
            setupRainAnimation(emitter: emitter)
        case .thunderstorm:
            setupThunderstormAnimation(emitter: emitter)
        case .clear:
            setupClearAnimation(emitter: emitter)
        case .cloudy, .partlyCloudy:
            setupCloudyAnimation(emitter: emitter)
        }
    }
}

private extension AnimationView {
    
    func setupSnowAnimation(emitter: CAEmitterLayer) {
        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        let near = makeEmitterCell(color: UIColor(white: 1, alpha: 1), velocity: 100, scale: 0.3)
        let middle = makeEmitterCell(color: UIColor(white: 1, alpha: 0.66), velocity: 80, scale: 0.2)
        let far = makeEmitterCell(color: UIColor(white: 1, alpha: 0.33), velocity: 60, scale: 0.1)
        
        emitter.emitterCells = [near, middle, far]
    }
    
    func setupRainAnimation(emitter: CAEmitterLayer) {
        emitter.emitterShape = .line
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitter.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        let rainCell = makeEmitterCell(color: UIColor.blue.withAlphaComponent(0.8), velocity: 200, scale: 0.1)
        rainCell.emissionLongitude = .pi
        rainCell.emissionRange = 0
        rainCell.yAcceleration = 200
        rainCell.xAcceleration = 0
        rainCell.birthRate = 30
        rainCell.velocity = 300
        
        emitter.emitterCells = [rainCell]
        
        setupCloudAnimation()
    }
    
    func setupCloudAnimation() {
        let cloudEmitter = CAEmitterLayer()
        cloudEmitter.emitterShape = .rectangle
        cloudEmitter.emitterPosition = CGPoint(x: -bounds.size.width / 2, y: bounds.midY)
        cloudEmitter.emitterSize = CGSize(width: bounds.size.width * 2, height: bounds.size.height)
        
        let cloudCell = makeEmitterCell(color: UIColor.gray.withAlphaComponent(0.5), velocity: 5, scale: 0.3)
        cloudCell.emissionLongitude = 0
        cloudCell.birthRate = 0.75
        cloudCell.lifetime = 50.0
        cloudCell.scale = 0.3
        cloudCell.scaleRange = 0.2
        cloudCell.velocity = 5
        cloudCell.velocityRange = 2
        cloudCell.yAcceleration = 0
        cloudCell.xAcceleration = 2
        cloudCell.contents = UIImage(named: "cloud")?.cgImage
        
        let lightCell = makeEmitterCell(color: .yellow, velocity: 10, scale: 0.05)
        lightCell.emissionLongitude = .pi
        lightCell.emissionRange = .pi / 4
        lightCell.birthRate = eventType == .partlyCloudy ? 5 : 0
        lightCell.lifetime = 20.0
        lightCell.velocity = 10
        lightCell.velocityRange = 5
        lightCell.yAcceleration = 0
        lightCell.xAcceleration = 0
        lightCell.contents = Images.WeatherEvent.particle.uiImage?.cgImage
        
        cloudEmitter.emitterCells = [cloudCell, lightCell]
        cloudEmitter.zPosition = 1
        
        self.layer.addSublayer(cloudEmitter)
    }

    func setupThunderstormAnimation(emitter: CAEmitterLayer) {
        let lightningLayer = CAShapeLayer()
        lightningLayer.frame = bounds
        lightningLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.insertSublayer(lightningLayer, at: 0)

        setupCloudAnimation()
        
        func createLightningPath() -> UIBezierPath {
            let path = UIBezierPath()
            let startX = CGFloat.random(in: 0...bounds.size.width)
            let startY = CGFloat.random(in: 0...bounds.size.height / 2)
            path.move(to: CGPoint(x: startX, y: startY))
            
            let numberOfPoints = Int.random(in: 5...10)
            var currentPoint = CGPoint(x: startX, y: startY)
            
            for _ in 0..<numberOfPoints {
                let nextPoint = CGPoint(x: currentPoint.x + CGFloat.random(in: -30...30),
                                        y: currentPoint.y + CGFloat.random(in: 30...100))
                path.addLine(to: nextPoint)
                currentPoint = nextPoint
            }
            
            return path
        }
        
        func createLightningAnimation() {
            let lightningPath = createLightningPath()
            
            let lightningShapeLayer = CAShapeLayer()
            lightningShapeLayer.path = lightningPath.cgPath
            lightningShapeLayer.strokeColor = UIColor.yellow.cgColor
            lightningShapeLayer.lineWidth = 2
            lightningShapeLayer.lineCap = .round
            lightningShapeLayer.opacity = 0
            lightningShapeLayer.backgroundColor = UIColor.clear.cgColor
            
            lightningLayer.addSublayer(lightningShapeLayer)
            
            let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
            fadeInAnimation.fromValue = 0
            fadeInAnimation.toValue = 1
            fadeInAnimation.duration = 0.1
            
            let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
            fadeOutAnimation.fromValue = 1
            fadeOutAnimation.toValue = 0
            fadeOutAnimation.beginTime = CACurrentMediaTime() + 0.1
            fadeOutAnimation.duration = 0.1
            
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [fadeInAnimation, fadeOutAnimation]
            animationGroup.duration = 0.2
            animationGroup.repeatCount = 1
            lightningShapeLayer.add(animationGroup, forKey: "lightning")
        }
        
        func triggerRandomLightning() {
            let interval = TimeInterval.random(in: 1.0...5.0)
            
            Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
                createLightningAnimation()
                triggerRandomLightning()
            }
        }
        
        triggerRandomLightning()
    }

    func setupClearAnimation(emitter: CAEmitterLayer) {
        emitter.emitterShape = .circle
        emitter.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitter.emitterSize = CGSize(width: bounds.size.width / 2, height: bounds.size.height / 2)
        
        let clearCell = makeEmitterCell(color: .white, velocity: 20, scale: 0.05)
        clearCell.emissionLongitude = 0
        clearCell.emissionRange = .pi * 2
        clearCell.velocity = 30
        clearCell.velocityRange = 10
        clearCell.yAcceleration = 0
        
        emitter.emitterCells = [clearCell]
    }
    
    func setupCloudyAnimation(emitter: CAEmitterLayer) {
        emitter.emitterShape = .rectangle
        emitter.emitterPosition = CGPoint(x: -bounds.size.width / 2, y: bounds.midY)
        emitter.emitterSize = CGSize(width: bounds.size.width * 2, height: bounds.size.height)
        
        let cloudCell = makeEmitterCell(color: UIColor.gray.withAlphaComponent(0.5), velocity: 5, scale: 0.3)
        cloudCell.emissionLongitude = 0
        cloudCell.birthRate = eventType == .cloudy ? 0.75 : 0.3
        cloudCell.lifetime = 50.0
        cloudCell.scale = 0.3
        cloudCell.scaleRange = 0.2
        cloudCell.velocity = 5
        cloudCell.velocityRange = 2
        cloudCell.yAcceleration = 0
        cloudCell.xAcceleration = 2
        cloudCell.contents = UIImage(named: "cloud")?.cgImage
        
        let lightCell = makeEmitterCell(color: .yellow, velocity: 10, scale: 0.05)
        lightCell.emissionLongitude = .pi
        lightCell.emissionRange = .pi / 4
        lightCell.birthRate = eventType == .cloudy ? 0 : 5
        lightCell.lifetime = 20.0
        lightCell.velocity = 10
        lightCell.velocityRange = 5
        lightCell.yAcceleration = 0
        lightCell.xAcceleration = 0
        lightCell.contents = Images.WeatherEvent.particle.uiImage?.cgImage
        
        emitter.emitterCells = [cloudCell, lightCell]
    }

    func makeEmitterCell(color: UIColor, velocity: CGFloat, scale: CGFloat) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 20.0
        cell.color = color.cgColor
        cell.velocity = velocity
        cell.velocityRange = velocity / 4
        cell.emissionLongitude = .pi
        cell.emissionRange = .pi / 8
        cell.scale = scale
        cell.scaleRange = scale / 3
        
        cell.contents = eventType.animationImage?.cgImage
        return cell
    }
}
