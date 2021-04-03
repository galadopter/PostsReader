//
//  PostsService.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Moya
import RxSwift

final class PostsService: NetworkService<PostsAPI>, GetPostsGateway, GetCommentsGateway {
    
    func getPosts() -> Single<Result<[Post], Error>> {
        network.fetchDecodable(.getPosts)
    }
    
    func getComments(postId: Int) -> Single<Result<[Comment], Error>> {
        network.fetchDecodable(.getComments(postId: postId))
    }
}
