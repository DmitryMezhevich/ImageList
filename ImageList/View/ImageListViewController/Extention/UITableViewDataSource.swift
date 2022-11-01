//
//  UITableViewDataSource.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit

// MARK: - UITableViewDataSource
extension ImageListViewController: UITableViewDataSource {
    
    // Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        imageListModel.count
    }
    
    // Create Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageListCell.reuseId, for: indexPath) as? ImageListCell else { fatalError() }
        
        return cell
    }
    
    // Will Display Cell
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ImageListCell else { fatalError() }
        
        let cellModel = imageListModel[indexPath.row]
        
        cell.updateCell(withData: cellModel)
        
        if cellModel.image != nil {
            viewModel.fetchImage(bundel: cellModel.image!, idOperation: cellModel.id) { image in
                DispatchQueue.main.async {
                    cell.updateCell(withImage: image)
                }
            }
        }
    }
    
    
    // Did End Displaying Cell
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cellModel = imageListModel[indexPath.row]
        
        if cellModel.image != nil {
            viewModel.removeFetchImageOperation(idOperation: cellModel.id)
        }
    }
    
    
}
