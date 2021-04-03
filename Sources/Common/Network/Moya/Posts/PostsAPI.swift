//
//  PostsAPI.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Foundation
import Moya

enum PostsAPI {
    case getPosts
}

extension PostsAPI: TargetType {
    
    public var needsAuth: Bool { true }
    
    public var baseURL: URL {
        return Credentials.Server.url
    }
    
    public var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getPosts:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
