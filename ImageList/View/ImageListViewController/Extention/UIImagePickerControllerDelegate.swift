//
//  UIImagePickerControllerDelegate.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit

// MARK: - UIImagePickerControllerDelegate
extension ImageListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        viewModel.post(withImage: image, id: viewModel.getCurrentIndexPath().row) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    UIAlertController.createAndPresentAlertWithOkButton(titleAlert: "Success 🥳", messageAlert: "Your id: \(success)", presenter: self)
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    UIAlertController.createAndPresentAlertWithOkButton(titleAlert: "Failure 🤔", messageAlert: failure.localizedDescription, presenter: self)
                }
            }
        }
    }
    
}
