//
//  UITableViewDelegate.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit
import AVFoundation

// MARK: - UITableViewDelegate
extension ImageListViewController: UITableViewDelegate {
    
    // Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.sendCurrentIndexPath(indexPath)
        
        UIAlertController.createAndPresentActionSheet(title: "Please, select source", firstButtonTitle: "Camera", secondButtonTitle: "Gallery", presenter: self) { [unowned self] result in
            switch result {
            case .firstButton:
                self.viewModel.requestAccessCamera { [weak self] result in
                    guard let self = self else { return }
                    if result {
                        if self.viewModel.getFirstRequestAccessCamera() {
                            self.viewModel.setFirstRequestAccessCamera()
                        }
                        self.createAlertOrSettingImagePicker(dependingResult: result)
                    } else {
                        guard !self.viewModel.getFirstRequestAccessCamera() else {
                            self.viewModel.setFirstRequestAccessCamera()
                            return
                        }
                        self.createAlertOrSettingImagePicker(dependingResult: result)
                    }
                }
            case .secondButton:
                settingImagePicker(source: .photoLibrary)
            case .cancel:
                break
            }
        }
    }
    
    
    // Private method for this Extention
    private func settingImagePicker(source: UIImagePickerController.SourceType) {
        DispatchQueue.main.async { [unowned self] in
            pickerController.sourceType = source
            self.present(pickerController, animated: true)
        }
    }
    
    private func createAlertOrSettingImagePicker(dependingResult result: Bool) {
        if result {
            settingImagePicker(source: .camera)
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                UIAlertController.createAndPresentAlertWithGoToURL(titleAlert: "Ops 🫢", messageAlert: "You can to change access from \"Setting\"", titleButton: "Go to \"Setting\"", presenter: self, viewModel: self.viewModel)
            }
        }
    }
}
