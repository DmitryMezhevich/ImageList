//
//  ImageListViewController.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit
import AVFoundation
import PhotosUI

class ImageListViewController: UIViewController {
    
    private(set) var imageList: ImageList
    private(set) var viewModel: ImageListViewModelProtocol
    private(set) var imageListModel: [CellDataModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.imageList.reloadData()
            }
        }
    }
    lazy var pickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    init(imageList: ImageList = ImageList(), viewModel: ImageListViewModelProtocol) {
        self.imageList = imageList
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSubview()
        settingService()
        
    }
    
    // MARK: - Private methods
    private func settingSubview() {
        view.addSubview(imageList)
        NSLayoutConstraint.activate([
            imageList.topAnchor.constraint(equalTo: view.topAnchor),
            imageList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageList.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        imageList.translatesAutoresizingMaskIntoConstraints = false
        
        view.applyGradients(cornerRadius: 10)
        
        imageList.delegate = self
        imageList.dataSource = self
    }
    
    private func settingService() {
        viewModel.data.bind { data in
            self.imageListModel = data
        }
        
        viewModel.fetchData()
    }
    
}
