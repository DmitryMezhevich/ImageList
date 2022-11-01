//
//  NetworkService.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import UIKit


class NetworkService: NetworkServiceProtocol {

    private var session: URLSession
    private var decode: JSONDecoder
    
    init(session: URLSession = .shared, decode: JSONDecoder = .init()) {
        self.session = session
        self.decode = decode
    }
    
}

// MARK: - GET methods
extension NetworkService {
    // Get any Data
    func getData(url: URL, completionHandler: @escaping (Result<Data?, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
            }
            
            completionHandler(.success(data))
        }.resume()
    }
    
    // Get data with any T: Decodable
    func getDataWithModelType<T: Decodable>(model: T.Type, url: URL, completionHandler: @escaping (Result<T, Error>) -> Void) {
        getData(url: url) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                
                let decode = self.decode(type: model.self, data: data)
                
                completionHandler(decode)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // Get Image
    func getImage(url: URL, completionHandler: @escaping (Result<UIImage?, Error>) -> Void) {
        getData(url: url) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                completionHandler(.success(UIImage(data: data)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    // Decode method
    private func decode<T: Decodable>(type: T.Type, data: Data) -> Result<T, Error> {
        do {
            let result = try decode.decode(type, from: data)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}


// MARK: - POST methods
extension NetworkService {
    func post(url: URL, name: String, object: Data, id: Int, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        // Create request and body
        var contentDispositionRequest = ContentDispositionRequest()
        contentDispositionRequest.url = url
        contentDispositionRequest.name = name
        contentDispositionRequest.id = id
        contentDispositionRequest.data = object
        contentDispositionRequest.createContext()

        guard let context = contentDispositionRequest.context else { return }
        
        URLSession.shared.uploadTask(with: context.request, from: context.body) { data, response, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                let decode = self.decode(type: ResponseService.self, data: data)
                switch decode {
                case .success(let success):
                    completionHandler(.success(success.id))
                case .failure(let failure):
                    completionHandler(.failure(failure))
                }
            } else {
                print((response as! HTTPURLResponse).statusCode)
            }
        }.resume()
    }
    
}
