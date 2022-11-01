//
//  ContentDispositionRequestProtocol.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import Foundation


protocol ContentDispositionRequestProtocol {
    var context: ContentDispositionModel? { get }
    var url: URL? { get set }
    var name: String? { get set }
    var id: Int? { get set }
    var data: Data? { get set }
    
    mutating func createContext()
}
