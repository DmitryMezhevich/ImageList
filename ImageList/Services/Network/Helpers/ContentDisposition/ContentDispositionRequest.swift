//
//  ContentDispositionRequest.swift
//  Images List
//
//  Created by Дмитрий Межевич on 1.11.22.
//

import Foundation

// MARK: - Чуть позже напишу универсальный объект для запросов
struct ContentDispositionRequest: ContentDispositionRequestProtocol {
    
    var context: ContentDispositionModel?
    var url: URL?
    var name: String?
    var id: Int?
    var data: Data?
    
    mutating func createContext() {
        
        // Constent
        let boundery: String = randomBoundary()
        let lineBreak: String = "\r\n"
        
        // Create Request
        guard let url = url else { return }
        context = ContentDispositionModel(request: URLRequest(url: url), body: Data())
        context?.request.httpMethod = "POST"
        context?.request.setValue("multipart/form-data; boundary=\(boundery)", forHTTPHeaderField: "Content-Type")
        
        
        // Create data body
        // ---------------- Start (Name) ----------------
        context?.body.append("--\(boundery)".formatData())
        context?.body.append(lineBreak.formatData())
        
        
        context?.body.append("Content-Disposition: form-data; name=\"name\"".formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append("\(name ?? "I'm not have name")".formatData())
        
        // ---------------- Encapsulated (Image data) ----------------
        context?.body.append(lineBreak.formatData())
        context?.body.append("--\(boundery)".formatData())
        context?.body.append(lineBreak.formatData())
        
        
        context?.body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"MyFace.jpg\"".formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append("Content-Type: image/jpeg".formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append(data ?? "not data".formatData())
        
        // ---------------- Encapsulated (type ID) ----------------
        context?.body.append(lineBreak.formatData())
        context?.body.append("--\(boundery)".formatData())
        context?.body.append(lineBreak.formatData())
        
        context?.body.append("Content-Disposition: form-data; name=\"typeId\"".formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append(lineBreak.formatData())
        context?.body.append(String(id ?? 0).formatData())
        
        
        // ---------------- End ----------------
        context?.body.append(lineBreak.formatData())
        context?.body.append("--\(boundery)--".formatData())
    }
    
}


extension ContentDispositionRequest {
    
    private func randomBoundary() -> String {
        let first = UInt32.random(in: UInt32.min...UInt32.max)
        let second = UInt32.random(in: UInt32.min...UInt32.max)

        return String(format: "dmitry.boundary.%08x%08x", first, second)
    }
}
