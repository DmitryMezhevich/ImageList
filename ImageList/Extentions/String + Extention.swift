//
//  String + Extention.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import Foundation

extension String {
    func formatData() -> Data {
        self.data(using: .utf8)!
    }
}
