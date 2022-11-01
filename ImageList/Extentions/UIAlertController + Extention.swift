//
//  UIAlertController + Extention.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit

extension UIAlertController {
    
    enum СhoiceActionSheet {
        case firstButton
        case secondButton
        case cancel
    }
    
    static func createAndPresentActionSheet(title: String, message: String? = nil, firstButtonTitle: String, secondButtonTitle: String, presenter: UIViewController, animtion: Bool = true, handler: @escaping (СhoiceActionSheet) -> Void) {
        
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let firstButton = UIAlertAction(title: firstButtonTitle, style: .default) { _ in
            handler(.firstButton)
        }
        let secondButton = UIAlertAction(title: secondButtonTitle, style: .default) { _ in
            handler(.secondButton)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            handler(.cancel)
        }
        
        actionSheet.addAction(firstButton)
        actionSheet.addAction(secondButton)
        actionSheet.addAction(cancelButton)
        
        presenter.present(actionSheet, animated: animtion)
    }
    
    static func createAndPresentAlertWithGoToURL(titleAlert: String, messageAlert: String, titleButton: String, presenter: UIViewController, animation: Bool = true, viewModel: ImageListViewModelProtocol) {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        
        let buttonAction = UIAlertAction(title: titleButton, style: .default) { _ in
            viewModel.goToSetting()
        }
        let cencelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(buttonAction)
        alert.addAction(cencelAction)
        
        presenter.present(alert, animated: animation)
    }
    
    static func createAndPresentAlertWithOkButton(titleAlert: String, messageAlert: String, titleButton: String = "Ok", presenter: UIViewController, animation: Bool = true) {
        let alert = UIAlertController(title: titleAlert, message: messageAlert, preferredStyle: .alert)
        
        let buttonAction = UIAlertAction(title: titleButton, style: .default)
        
        alert.addAction(buttonAction)
        
        presenter.present(alert, animated: animation)
    }
    
}
