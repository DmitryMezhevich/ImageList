//
//  Constants.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import Foundation

struct Constants {
    
    enum UserDefaults: String {
        case requestAccessCamera
    }
    
    enum Different: String {
        case nameForSerialQueue =   "AppendAndRemoveOperation"
        case developerName =        "Dmitry Mezhevich"
    }
    
    enum StringURL: String {
        case get =  "https://junior.balinasoft.com/api/v2/photo/type"
        case post = "https://junior.balinasoft.com/api/v2/photo"
    }
}
