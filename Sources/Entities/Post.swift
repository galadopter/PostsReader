//
//  Post.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation

struct Post: Codable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
