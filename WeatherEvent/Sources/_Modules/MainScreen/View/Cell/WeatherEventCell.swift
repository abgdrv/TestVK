//
//  WeatherEventCell.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

final class WeatherEventCell: UICollectionViewCell {
    
    var cellSelected: Bool = false {
        didSet {
            containerView.backgroundColor = cellSelected ? selectedColor : color
        }
    }
    
    private var color: UIColor?
    private var selectedColor: UIColor?
    
    private lazy var containerView = UIView().apply {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
    }
    
    private lazy var imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var titleLabel = UILabel().apply {
        $0.set(font: .systemFont(ofSize: 10, weight: .medium), textColor: Colors.mainTitle.uiColor, textAlignment: .center)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WeatherEventCell {
    
    func setupViews() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubviews(imageView, titleLabel)
    }
    
    func setupConstraints() {
        containerView.matchSuperview(withInsets: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
        
        imageView.setSize(width: 50, height: 50)
        imageView.constraint(
            top: containerView.topAnchor,
            insets: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        )
        imageView.centerXInSuperview()
        
        titleLabel.constraint(
            top: imageView.bottomAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            insets: UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
        )
    }
}

extension WeatherEventCell {
    
    func setCell(model: WeatherEvent, backgroundColor: UIColor, borderColor: UIColor) {
        titleLabel.text = model.title
        imageView.image = model.image
        
        containerView.backgroundColor = backgroundColor
        containerView.layer.borderColor = borderColor.withAlphaComponent(0.3).cgColor
        
        color = backgroundColor
        selectedColor = model == .thunderstorm ? borderColor.withAlphaComponent(0.3) : backgroundColor.withAlphaComponent(1.5)
        
        titleLabel.textColor = backgroundColor.isDarkColor ? .white : .black
    }
}
