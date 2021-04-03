//
//  GetCommentsUseCase.swift
//  PostsReader
//
//  Created by Yan Schneider on 4.04.21.
//

import Foundation
import RxSwift

protocol GetCommentsGateway {
    func getComments(postId: Int) -> Single<Result<[Comment], Error>>
}

struct GetCommentsUseCase {
    let postId: Int
    let gateway: GetCommentsGateway
}

extension GetCommentsUseCase: UseCaseType {
    
    typealias Input = Observable<Void>
    
    struct Output {
        let comments: Observable<[Comment]>
        let errors: Observable<Error>
        let isLoading: Observable<Bool>
    }
    
    func execute(input: Input) -> Output {
        let isLoadingSubject = BehaviorSubject<Bool>(value: false)
        let commentsResult = comments(from: input, isLoadingSubject: isLoadingSubject).share()
        
        let comments = commentsResult.compactMap { try? $0.get() }
        let errors = commentsResult.compactMap { result -> Error? in
            guard case let .failure(error) = result else { return nil }
            return error
        }
        
        return .init(comments: comments, errors: errors, isLoading: isLoadingSubject.asObservable())
    }
    
    private func comments(from input: Input, isLoadingSubject: BehaviorSubject<Bool>) -> Observable<Result<[Comment], Error>> {
        input
            .do(onNext: { isLoadingSubject.onNext(true) })
            .flatMap { gateway.getComments(postId: postId).asObservable() }
            .do(
                onNext: { _ in isLoadingSubject.onNext(false) },
                onError: { _ in isLoadingSubject.onNext(false) }
            )
    }
}
