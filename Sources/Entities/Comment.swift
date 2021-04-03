//
//  Comment.swift
//  PostsReader
//
//  Created by Yan Schneider on 4.04.21.
//

import Foundation

struct Comment: Codable, Equatable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
