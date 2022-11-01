//
//  Box.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import Foundation

final class Box<T> {
    
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
}
