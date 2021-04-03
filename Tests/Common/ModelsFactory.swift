//
//  ModelsFactory.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation
@testable import PostsReader

struct ModelsFactory {
    
    static func posts(
        count: Int = 2
    ) -> [Post] {
        (1...count).map { Self.post(id: $0) }
    }
    
    static func post(
        id: Int = 0,
        userId: Int = 0,
        title: String = "",
        body: String = ""
    ) -> Post {
        Post(
            id: id,
            userId: userId,
            title: title,
            body: body
        )
    }
    
    static func error(
        message: String = ""
    ) -> Error {
        InternalError(
            message: message
        )
    }
}
