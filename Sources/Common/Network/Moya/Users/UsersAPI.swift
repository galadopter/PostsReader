//
//  UsersAPI.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import Foundation
import Moya

enum UsersAPI {
    case getUser(id: Int)
}

extension UsersAPI: TargetType {
    
    public var baseURL: URL {
        return Credentials.Server.url
    }
    
    public var path: String {
        switch self {
        case .getUser(let id):
            return "/users/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getUser:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}

