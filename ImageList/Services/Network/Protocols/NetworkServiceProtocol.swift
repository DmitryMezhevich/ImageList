//
//  NetworkServiceProtocol.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import UIKit


protocol NetworkServiceProtocol {
    
    func getData(url: URL, completionHandler: @escaping (Result<Data?, Error>) -> Void)
    func getDataWithModelType<T: Decodable>(model: T.Type, url: URL, completionHandler: @escaping (Result<T, Error>) -> Void)
    func getImage(url: URL, completionHandler: @escaping (Result<UIImage?, Error>) -> Void)
    func post(url: URL, name: String, object: Data, id: Int, completionHandler: @escaping (Result<String, Error>) -> Void)
}
