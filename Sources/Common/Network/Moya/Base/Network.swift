//
//  Network.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Foundation
import RxSwift
import RxMoya
import Moya

struct Network<API: TargetType> {
    
    private let provider: MoyaProvider<API>
    private let interceptor: NetworkInterceptor
    
    private typealias NetworkError = NetworkErrors.GenericError
    
    init(provider: MoyaProvider<API>, interceptor: NetworkInterceptor) {
        self.provider = provider
        self.interceptor = interceptor
    }
    
    func send(_ api: API) -> Single<Result<Void, Error>> {
        return makeRequest(to: api).map { result in
            return result.map { _ in }
        }
    }
    
    func fetchString(_ api: API) -> Single<Result<String, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                guard let data = try? response.mapString() else { return .failure(NetworkError(response: response)) }
                return .success(data)
            }
        }
    }
    
    func fetchValue<T>(_ api: API, key: String? = nil) -> Single<Result<T, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                let valueForKey = key.flatMap { response.json?[$0] as? T }
                guard let data = valueForKey ?? (try? response.mapJSON()).flatMap({ $0 as? T }) else { return .failure(NetworkError(response: response)) }
                return .success(data)
            }
        }
    }
    
    func fetchDecodable<T: Decodable>(_ api: API, decoder: JSONDecoder = .init()) -> Single<Result<T, Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                guard let data = try? decoder.decode(T.self, from: response.data)
                    else { return .failure(NetworkError(response: response)) }
                return .success(data)
            }
        }
    }
    
    func fetchValueArray<T>(_ api: API, key: String? = nil) -> Single<Result<[T], Error>> {
        return makeRequest(to: api).map { result in
            return result.flatMap { response in
                let arrayForKey = key.flatMap { response.json?[$0] as? [T] }
                guard let data = arrayForKey ?? (try? response.mapJSON()).flatMap({ $0 as? [T] })
                else {
                    return .failure(NetworkError(response: response))
                }
                return .success(data)
            }
        }
    }
    
    private func makeRequest(to api: API) -> Single<Result<Response, Error>> {
        return provider.rx.request(api)
            .map { self.interceptor.intercept(response: $0) }
            .catchError { return Single.just(.failure(NetworkError(message: $0.localizedDescription)))}
    }
}
