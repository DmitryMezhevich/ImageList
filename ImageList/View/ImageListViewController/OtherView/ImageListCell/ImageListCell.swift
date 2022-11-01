//
//  ImageListCell.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit

class ImageListCell: UITableViewCell {
    
    static let reuseId = "ImageListCell"
    
    private lazy var subView: ImageListCellView = {
        let view = ImageListCellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        settingCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        subView.webImage.image = nil
        
        layer.removeAllAnimations()
    }
    
}


// MARK: - Extention with methods
extension ImageListCell {
    
    // Update cell methods
    func updateCell(withData data: CellDataModel) {
        subView.lable.text = data.name
        
        if data.image == nil {
            subView.webImage.image = UIImage(named: "ImageNotFound")
        }
        
        layer.animation(forRath: "opacity", withName: "myOpacityanimation", fromValue: 0, toValue: 1, duration: 0.25)
    }
    
    func updateCell(withImage image: UIImage?) {
        if let image = image {
            subView.webImage.image = image
        } else {
            subView.webImage.image = UIImage(named: "ImageNotFound")
        }
    }
    
    // Private methods
    private func settingCell() {
        addSubview(subView)
        
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: leadingAnchor),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor),
            subView.topAnchor.constraint(equalTo: topAnchor),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        backgroundColor = .clear
        selectionStyle = .none
    }
}
