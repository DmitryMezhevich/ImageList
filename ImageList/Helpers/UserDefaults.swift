//
//  UserDefaults.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    
    private var key: Constants.UserDefaults
    private var storeg: UserDefaults
    private var defaultValue: T
    
    init(_ key: Constants.UserDefaults, storeg: UserDefaults = .standard, defaultValue: T) {
        self.key = key
        self.storeg = storeg
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get { storeg.value(forKey: key.rawValue) as? T ?? defaultValue }
        set { storeg.set(newValue, forKey: key.rawValue) }
    }
}
