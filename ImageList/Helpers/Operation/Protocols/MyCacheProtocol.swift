//
//  MyCacheProtocol.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import Foundation

protocol MyCacheProtocol {
    associatedtype Object
    
    func getToObject(withBundel bundel: String) -> Object?
    func setToObject(withBundel bundel: String, object: Object)
}
