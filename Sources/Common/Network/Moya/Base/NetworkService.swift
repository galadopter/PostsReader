//
//  NetworkService.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Moya

class NetworkService<API: TargetType> {
    let network: Network<API>
    
    init(provider: MoyaProvider<API> = MoyaProvider(), interceptor: NetworkInterceptor = StandardNetworkInterceptor()) {
        self.network = Network(provider: provider, interceptor: interceptor)
    }
}
