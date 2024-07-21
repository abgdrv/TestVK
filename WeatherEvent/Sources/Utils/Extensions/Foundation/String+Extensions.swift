//
//  String+Extensions.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 20.07.2024.
//

import Foundation

extension String {
    
    var localized: String {
        let lang = UserDefaultsService.shared.lang
        
        if let bundlePath = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj"),
           let bundle = Bundle(path: bundlePath) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
        } else {
            if let bundlePath = Bundle.main.path(forResource: LanguageType.en.rawValue, ofType: "lproj"),
               let bundle = Bundle(path: bundlePath) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
            }
            return NSLocalizedString(self, comment: "")
        }
    }
}
