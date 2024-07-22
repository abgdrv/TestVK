//
//  NSObject+Extensions.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import Foundation

protocol InlineConfigurable {}

extension NSObject: InlineConfigurable {}

extension InlineConfigurable {
    
    @discardableResult func apply(_ configurator: (Self) -> Void) -> Self {
        configurator(self)
        return self
    }
}
