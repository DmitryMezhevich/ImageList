//
//  ImageListViewModel.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit
import AVFoundation


class ImageListViewModel: ImageListViewModelProtocol {
    
    private var networkService: NetworkServiceProtocol
    private var currentSelectIndexPath: IndexPath
    private lazy var getImageObject: GetImageObjectProtocol = {
        return GetImageObject(service: networkService)
    }()
    @UserDefault(Constants.UserDefaults.requestAccessCamera, defaultValue: true) private var firstRequestAccessCamera: Bool
    
    var data: Box<[CellDataModel]>
    
    init(networkService: NetworkServiceProtocol = NetworkService(), currentSelectIndexPath: IndexPath = IndexPath()) {
        self.networkService = networkService
        self.currentSelectIndexPath = currentSelectIndexPath
        self.data = Box<[CellDataModel]>([])
    }
    
}

// MARK: - Methods
extension ImageListViewModel {
    
    func sendCurrentIndexPath(_ indexPath: IndexPath) {
        currentSelectIndexPath = indexPath
    }
    
    func getCurrentIndexPath() -> IndexPath {
        currentSelectIndexPath
    }
    
    
    func requestAccessCamera(completionHandler: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { result in
            completionHandler(result)
        }
    }
    
    func goToSetting() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
    func setFirstRequestAccessCamera() {
        firstRequestAccessCamera = false
    }
    
    func getFirstRequestAccessCamera() -> Bool {
        firstRequestAccessCamera
    }
}

// MARK: - Work with GET and POST method
extension ImageListViewModel {
    
    func fetchData() {
        
        guard let url = URL(string: Constants.StringURL.get.rawValue) else { return }
        
        networkService.getDataWithModelType(model: ImageListModel.self, url: url) { result in
            switch result {
            case .success(let success):
                
                var cellData: [CellDataModel] = []
                
                success.content.forEach { content in
                    cellData.append(CellDataModel(id: content.id, name: content.name, image: content.image))
                }
                
                self.data.value = cellData
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    
    func post(withImage image: UIImage, id: Int, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard
            let url = URL(string: Constants.StringURL.post.rawValue),
            let jpegImage = image.jpegData(compressionQuality: 0.3)
        else { return }
        
        networkService.post(url: url, name: Constants.Different.developerName.rawValue, object: jpegImage, id: id) { result in
            switch result {
            case .success(let success):
                completionHandler(.success(success))
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
    }
}

// MARK: - Work with operation
extension ImageListViewModel {
    func fetchImage(bundel: String, idOperation id: Int, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            self.getImageObject.createGetImageOperation(imageBundel: bundel, id: id) { image in
                completion(image)
            }
        }
    }
    
    func removeFetchImageOperation(idOperation id: Int) {
        // Here I remove session task on a main thread
        getImageObject.removeGetImageOperation(id: id)
    }
}
