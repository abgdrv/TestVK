//
//  MainScreenViewController.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

final class MainScreenViewController: BaseViewController, MainScreenView {
    
    var didFinish: VoidCallback?
    var didChangeLanguage: VoidCallback?
    
    private var selectedIndexPath: IndexPath? {
        didSet {
            if let indexPath = selectedIndexPath {
                viewModel.currentEventNumber = indexPath.row
            }
        }
    }
    
    private let viewModel: MainScreenViewModel
    
    private lazy var languageButton = UIBarButtonItem(
        title: LocalizableKeys.language.localized,
        style: .plain,
        target: self,
        action: #selector(changeLanguage)
    )
    
    private lazy var gradientView = GradientView().apply {
        $0.setColors(
            startColor: viewModel.currentEvent.colors.0,
            midColor: viewModel.currentEvent.colors.1,
            endColor: viewModel.currentEvent.colors.2
        )
    }
    
    private lazy var topContainerView = UIView().apply {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
        $0.backgroundColor = viewModel.currentEvent.colors.1?.withAlphaComponent(1.2) ?? viewModel.currentEvent.colors.0.withAlphaComponent(1.2)
    }
    
    private let flowLayout = UICollectionViewFlowLayout().apply {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 5
        $0.minimumInteritemSpacing = 5
        $0.itemSize = CGSize(width: UIScreen.main.bounds.width / 5, height: 110)
        $0.sectionInset = .init(top: 2, left: 0, bottom: 2, right: 0)
    }
    
    private lazy var weatherEventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).apply {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.registerCell(WeatherEventCell.self)
    }
    
    private lazy var weatherEventImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)).apply {
        $0.image = viewModel.currentEvent.image
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var weatherEventTitleLabel = UILabel().apply {
        $0.set(font: .systemFont(ofSize: 36, weight: .bold), textColor: .white, textAlignment: .center)
        $0.text = viewModel.currentEvent.title
    }
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        selectedIndexPath = IndexPath(row: viewModel.currentEventNumber, section: 0)
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupViews()
        setupConstraints()
        setupAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selectedIndexPath = selectedIndexPath {
            DispatchQueue.main.async {
                self.weatherEventsCollectionView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: false)
            }
        }
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(WeatherEventCell.self, indexPath: indexPath)
        
        cell.setCell(
            model: viewModel.weatherEvents[indexPath.row],
            backgroundColor: viewModel.currentEvent.colors.1 ?? viewModel.currentEvent.colors.0,
            borderColor: viewModel.currentEvent.colors.2
        )
        
        cell.cellSelected = indexPath == selectedIndexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != indexPath {
            selectedIndexPath = indexPath
            updateWeatherEvent()
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.reloadData()
        }
    }
}

private extension MainScreenViewController {
    
    func setupViews() {
        view.addSubviews(gradientView, topContainerView, weatherEventImageView, weatherEventTitleLabel)
        topContainerView.addSubview(weatherEventsCollectionView)
    }
    
    func setupConstraints() {
        gradientView.matchSuperview()
        
        topContainerView.constraint(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            insets: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        )
        topContainerView.setHeight(126)
        
        weatherEventsCollectionView.matchSuperview(withInsets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        
        weatherEventImageView.constraint(leading: view.leadingAnchor, trailing: view.trailingAnchor)
        weatherEventImageView.centerYInSuperview()
        weatherEventImageView.setSize(width: UIDevice.current.isSmall ? 100 : 150, height: UIDevice.current.isSmall ? 100 : 150)
        
        weatherEventTitleLabel.constraint(
            top: weatherEventImageView.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            insets: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        )
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: viewModel.currentEvent.colors.0.isDarkColor ? Colors.grayTitle.uiColor : .black
        ]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = LocalizableKeys.appName.localized
        navigationItem.rightBarButtonItem = languageButton
        languageButton.tintColor = viewModel.currentEvent.colors.0.isDarkColor ? Colors.grayTitle.uiColor : .black
    }
}

private extension MainScreenViewController {
    
    func setupAnimation() {
        weatherEventImageView.shake()
        setupBackgroundAnimation()
    }
    
    func setupBackgroundAnimation() {
        gradientView.subviews.forEach {
            if $0 is Animatable {
                $0.removeFromSuperview()
            }
        }
        
        let animationView = AnimationView(eventType: viewModel.currentEvent)
        
        gradientView.addSubview(animationView)
        
        animationView.matchSuperview()
    }
    
    func updateWeatherEvent() {
        setupNavigation()
        
        let event = viewModel.currentEvent
        
        animateWeatherEventChange(to: event.image, newTitle: event.title)
        
        topContainerView.backgroundColor = event.colors.1?.withAlphaComponent(1.2) ?? event.colors.0.withAlphaComponent(1.2)
        
        gradientView.setColors(
            startColor: event.colors.0,
            midColor: event.colors.1,
            endColor: event.colors.2
        )
        
        setupBackgroundAnimation()
    }
    
    func animateWeatherEventChange(to newImage: UIImage?, newTitle: String?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.weatherEventImageView.alpha = 0
            self.weatherEventTitleLabel.alpha = 0
        }, completion: { _ in
            self.weatherEventImageView.image = newImage
            self.weatherEventTitleLabel.text = newTitle
            
            UIView.animate(withDuration: 0.3) {
                self.weatherEventImageView.alpha = 1
                self.weatherEventTitleLabel.alpha = 1
            }
        })
    }
}

private extension MainScreenViewController {
    @objc func changeLanguage() {
        viewModel.changeLanguage()
        didChangeLanguage?()
    }
}
