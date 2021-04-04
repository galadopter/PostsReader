//
//  NetworkUtils.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Moya

extension Response {
    
    var json: [String: Any]? {
        return (try? mapJSON()) as? [String: Any]
    }
}
