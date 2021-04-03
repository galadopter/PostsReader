//
//  GetPostsUseCase.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation
import RxSwift

protocol GetPostsGateway {
    func getPosts() -> Single<Result<[Post], Error>>
}

struct GetPostsUseCase {
    let gateway: GetPostsGateway
}

extension GetPostsUseCase: UseCaseType {
    
    typealias Input = Observable<Void>
    
    struct Output {
        let posts: Observable<[Post]>
        let errors: Observable<Error>
        let isLoading: Observable<Bool>
    }
    
    func execute(input: Input) -> Output {
        let isLoadingSubject = BehaviorSubject<Bool>(value: false)
        let postsResult = posts(from: input, isLoadingSubject: isLoadingSubject).share()
        
        let posts = postsResult.compactMap { try? $0.get() }
        let errors = postsResult.compactMap { result -> Error? in
            guard case let .failure(error) = result else { return nil }
            return error
        }
        
        return .init(posts: posts, errors: errors, isLoading: isLoadingSubject.asObservable().debug())
    }
    
    private func posts(from input: Input, isLoadingSubject: BehaviorSubject<Bool>) -> Observable<Result<[Post], Error>> {
        input
            .do(onNext: { isLoadingSubject.onNext(true) })
            .flatMap { gateway.getPosts().asObservable() }
            .do(
                onNext: { _ in isLoadingSubject.onNext(false) },
                onError: { _ in isLoadingSubject.onNext(false) }
            )
    }
}
