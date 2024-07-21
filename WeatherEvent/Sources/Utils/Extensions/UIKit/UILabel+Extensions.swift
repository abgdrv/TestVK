//
//  UILabel+Extensions.swift
//  WeatherEvent
//
//  Created by Almat Begaidarov on 21.07.2024.
//

import UIKit

extension UILabel {
    
    func set(font: UIFont, textColor: UIColor, textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    func setTyping(text: String, characterDelay: TimeInterval, competion: @escaping VoidCallback) {        
        self.text = ""
        
        let writingTask = DispatchWorkItem { [weak self] in
            text.forEach { char in
                DispatchQueue.main.async {
                    self?.text?.append(char)
                    competion()
                }
                
                Thread.sleep(forTimeInterval: characterDelay / 25)
            }
        }
        
        let queue: DispatchQueue = .init(label: "typespeed", qos: .userInteractive)
        queue.asyncAfter(deadline: .now() + 0.05, execute: writingTask)
    }
}
