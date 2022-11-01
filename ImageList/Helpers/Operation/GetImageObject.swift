//
//  GetImageObject.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit

class GetImageObject: GetImageObjectProtocol {
    
    private let service: NetworkServiceProtocol
    private var allOperation: [Int: AsyncOperation]
    private var concurrentOperationQueue: OperationQueue
    private var serialQueue: DispatchQueue
    private var imageCache: MyCache<UIImage>
    
    init(service: NetworkServiceProtocol, concurrentOperationQueue: OperationQueue = OperationQueue(), serialQueue: DispatchQueue = DispatchQueue(label: Constants.Different.nameForSerialQueue.rawValue), imageCache: MyCache<UIImage> = MyCache<UIImage>()) {
        self.service = service
        self.allOperation = [:]
        self.concurrentOperationQueue = concurrentOperationQueue
        self.serialQueue = serialQueue
        self.imageCache = imageCache
    }
    
    // Create operation
    func createGetImageOperation(imageBundel bundel: String, id: Int, completion: @escaping (UIImage?) -> Void) {
        
        // TODO: - Create cache
        if let image = imageCache.getToObject(withBundel: bundel) {
            completion(image)
            return
        }
        
        guard let urlImage = URL(string: bundel) else { completion(nil); return }
        
        let getImageOperation = GetImageOperation(url: urlImage, id: id, service: service)
        
        allOperation.updateValue(getImageOperation, forKey: id)
        
        getImageOperation.completionBlock = { [unowned self] in
            self.serialQueue.async {
                self.allOperation[id] = nil
            }
            
            guard let image = getImageOperation.image else { completion(nil); return }
            
            // TODO: - image add to cache
            DispatchQueue.global().async {
                self.imageCache.setToObject(withBundel: bundel, object: image)
            }
            
            completion(image)
        }
        
        concurrentOperationQueue.addOperation(getImageOperation)
    }
    
    // Remove operation
    func removeGetImageOperation(id: Int) {
        allOperation[id]?.cancel()
        serialQueue.async { [unowned self] in
            self.allOperation[id] = nil
        }
    }
    
}
