//
//  AsyncOperation.swift
//  Test
//
//  Created by Дмитрий Межевич on 27.10.22.
//

import Foundation

class AsyncOperation: Operation {
    enum State: String {
        case isReady, isExecuting, isFinished
    }
    
    var state: State = .isReady {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isReady: Bool {
        super.isReady && state == .isReady
    }
    
    override var isExecuting: Bool {
        state == .isExecuting
    }
    
    override var isFinished: Bool {
        state == .isFinished
    }
    
    override var isConcurrent: Bool {
        true
    }
    
    override func cancel() {
        state = .isFinished
    }
    
    override func start() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        
        main()
    }
}
