//
//  CALayer + Extention.swift
//  Test
//
//  Created by Дмитрий Межевич on 28.10.22.
//

import UIKit

extension CALayer {
    
    func animation(forRath path: String, withName name: String, fromValue: Any, toValue: Any, duration: CGFloat) {
        let animation = CABasicAnimation(keyPath: path)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        self.add(animation, forKey: name)
    }
}
