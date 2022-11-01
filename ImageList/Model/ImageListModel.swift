//
//  ImageListModel.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import Foundation

struct ImageListModel: Codable {
    var page: Int
    var pageSize: Int
    var totalPages: Int
    var totalElements: Int
    var content: [Content]
    
    struct Content: Codable {
        var id: Int
        var name: String
        var image: String?
    }
}
