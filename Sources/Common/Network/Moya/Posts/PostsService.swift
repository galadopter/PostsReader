//
//  PostsService.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Moya
import RxSwift

final class PostsService: NetworkService<PostsAPI>, GetPostsGateway {
    
    func getPosts() -> Single<Result<[Post], Error>> {
        network.fetchDecodable(.getPosts)
    }
}
