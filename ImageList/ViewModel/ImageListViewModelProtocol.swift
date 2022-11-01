//
//  ImageListViewModelProtocol.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit


protocol ImageListViewModelProtocol {
    
    var data: Box<[CellDataModel]> { get }
    
    func fetchData()
    func fetchImage(bundel: String, idOperation id: Int, completion: @escaping (UIImage?) -> Void)
    func removeFetchImageOperation(idOperation id: Int)
    func post(withImage image: UIImage, id: Int, completionHandler: @escaping (Result<String, Error>) -> Void)
    func sendCurrentIndexPath(_ indexPath: IndexPath)
    func getCurrentIndexPath() -> IndexPath
    func requestAccessCamera(completionHandler: @escaping (Bool) -> Void)
    func goToSetting()
    func setFirstRequestAccessCamera()
    func getFirstRequestAccessCamera() -> Bool
    
}
