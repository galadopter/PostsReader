//
//  NetworkErrors.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Moya

enum NetworkErrors {
    
    struct GenericError: AppError {
        var message: String
        
        init(message: String) {
            self.message = message
        }
        
        init(response: Response) {
            self.init(message: "Failed to map data to JSON. JSON: \((try? response.mapString()) ?? "No JSON")")
        }
    }
    
    struct NotFoundError: AppError {
        var message: String
        
        init(message: String) {
            self.message = message
        }
        
        init?(response: Response) {
            guard let message = try? response.mapString() else { return nil }
            self.init(message: message)
        }
    }
    
    struct NoContentError: Error {
        
    }
}
