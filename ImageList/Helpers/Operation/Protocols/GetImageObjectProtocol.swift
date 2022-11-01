//
//  GetImageObjectProtocol.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit


protocol GetImageObjectProtocol {
    func createGetImageOperation(imageBundel bundel: String, id: Int, completion: @escaping (UIImage?) -> Void)
    func removeGetImageOperation(id: Int)
}
