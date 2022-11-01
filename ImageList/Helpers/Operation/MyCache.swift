//
//  MyCache.swift
//  Test
//
//  Created by Дмитрий Межевич on 28.10.22.
//

import Foundation


class MyCache<T: AnyObject>: MyCacheProtocol {
    
    typealias Object = T
    
    private var cache: NSCache<NSString, T>
    
    init(cache: NSCache<NSString, T> = NSCache<NSString, T>()) {
        self.cache = cache
    }
    
    func getToObject(withBundel bundel: String) -> T? {
        cache.object(forKey: NSString(string: bundel))
    }
    
    func setToObject(withBundel bundel: String, object: T) {
        cache.setObject(object, forKey: NSString(string: bundel))
    }
}
