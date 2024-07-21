//
//  Builder.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import Foundation

public func build<T>(_ object: T, builder: (T) -> Void) -> T {
    builder(object)
    return object
}

public func build<T: NSObject>(builder: (T) -> Void) -> T {
    build(T.init(), builder: builder)
}
