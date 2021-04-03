//
//  UsersService.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import Moya
import RxSwift

final class UsersService: NetworkService<UsersAPI>, GetUserGateway {
    
    func getUser(userId: Int) -> Single<Result<User, Error>> {
        network.fetchDecodable(.getUser(id: userId))
    }
}
