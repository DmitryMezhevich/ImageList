//
//  GetImageOperation.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit

class GetImageOperation: AsyncOperation {
    
    var image: UIImage?
    let id: Int
    private let url: URL
    private let service: NetworkServiceProtocol
    
    init(url: URL, id: Int, service: NetworkServiceProtocol) {
        self.id = id
        self.url = url
        self.service = service
    }
    
    override func main() {
        service.getImage(url: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
                self?.state = .isFinished
            case .failure:
                self?.state = .isFinished
            }
        }
    }
    
}
