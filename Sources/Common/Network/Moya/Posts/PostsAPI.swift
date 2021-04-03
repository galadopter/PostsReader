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
    case getComments(postId: Int)
}

extension PostsAPI: TargetType {
    
    public var baseURL: URL {
        return Credentials.Server.url
    }
    
    public var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        case .getComments(let postId):
            return "/posts/\(postId)/comments"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getPosts, .getComments:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getPosts, .getComments:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return nil
    }
}
