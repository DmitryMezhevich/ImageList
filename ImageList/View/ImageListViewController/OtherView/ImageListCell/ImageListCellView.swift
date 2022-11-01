//
//  ImageListCellView.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit


class ImageListCellView: UIView {
    
    lazy var view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.634832263, green: 0.6774622798, blue: 0.7235186696, alpha: 0.7529237651)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var webImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var customBackgroundLable: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2786459923, green: 0.2843502164, blue: 0.2905603051, alpha: 1)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.layer.opacity = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var lable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = #colorLiteral(red: 0.9440798759, green: 0.9467794299, blue: 0.9823271632, alpha: 0.7036682533)
        lable.font = UIFont.boldSystemFont(ofSize: 36)
        lable.textAlignment = .center
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(view)
        view.addSubview(webImage)
        webImage.addSubview(customBackgroundLable)
        webImage.addSubview(lable)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            view.heightAnchor.constraint(equalToConstant: 300),
            
            webImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webImage.topAnchor.constraint(equalTo: view.topAnchor),
            webImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            customBackgroundLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            customBackgroundLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            customBackgroundLable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            customBackgroundLable.heightAnchor.constraint(equalToConstant: 40),
            
            lable.leadingAnchor.constraint(equalTo: customBackgroundLable.leadingAnchor),
            lable.trailingAnchor.constraint(equalTo: customBackgroundLable.trailingAnchor),
            lable.bottomAnchor.constraint(equalTo: customBackgroundLable.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
