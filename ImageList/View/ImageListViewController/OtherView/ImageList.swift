//
//  ImageList.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit

// MARK: - UITableView
final class ImageList: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        register(ImageListCell.self, forCellReuseIdentifier: ImageListCell.reuseId)
        separatorStyle = .none
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
