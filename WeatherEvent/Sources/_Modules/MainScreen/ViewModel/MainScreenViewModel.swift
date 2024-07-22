//
//  MainScreenViewModel.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import Foundation

final class MainScreenViewModel {
    
    let weatherEvents = WeatherEvent.allCases
    
    var currentEventNumber: Int {
        didSet {
            UserDefaultsService.shared.set(value: currentEventNumber, for: UserDefaultsKey.event.rawValue)
        }
    }
    
    var currentEvent: WeatherEvent {
        return weatherEvents[currentEventNumber]
    }
    
    init() {
        if let number = UserDefaultsService.shared.value(for: UserDefaultsKey.event.rawValue) as? Int {
            currentEventNumber = number
        } else {
            currentEventNumber = Int.random(in: 0..<weatherEvents.count)
            UserDefaultsService.shared.set(value: currentEventNumber, for: UserDefaultsKey.event.rawValue)
        }
    }
    
    func changeLanguage() {
        let lang = UserDefaultsService.shared.lang
        UserDefaultsService.shared.lang = lang == .en ? .ru : .en
    }
}
