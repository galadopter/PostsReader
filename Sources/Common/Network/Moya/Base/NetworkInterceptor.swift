//
//  NetworkInterceptor.swift
//  Taris
//
//  Created by Yan on 16.01.21.
//

import Moya

protocol NetworkInterceptor {
    func intercept(response: Response) -> Result<Response, Error>
}

struct StandardNetworkInterceptor: NetworkInterceptor {
    
    private let genericError = NetworkErrors.GenericError(message: "Something went wrong!")
    
    func intercept(response: Response) -> Result<Response, Error> {
        switch response.statusCode {
        case 200...399: return .success(response)
        case 404: return .failure(notFoundError(from: response))
        default: return .failure(NetworkErrors.GenericError(response: response))
        }
    }
    
    private func notFoundError(from response: Response) -> Error {
        guard let error = NetworkErrors.NotFoundError(response: response) else { return genericError }
        return error
    }
}
