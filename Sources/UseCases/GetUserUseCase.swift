//
//  GetUserUseCase.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation
import RxSwift

protocol GetUserGateway {
    func getUser(userId: Int) -> Single<Result<User, Error>>
}

struct GetUserUseCase {
    let userId: Int
    let gateway: GetUserGateway
}

extension GetUserUseCase: UseCaseType {
    
    typealias Input = Observable<Void>
    
    struct Output {
        let user: Observable<User>
        let errors: Observable<Error>
        let isLoading: Observable<Bool>
    }
    
    func execute(input: Input) -> Output {
        let isLoadingSubject = BehaviorSubject<Bool>(value: false)
        let userResult = user(from: input, isLoadingSubject: isLoadingSubject).share()
        
        let user = userResult.compactMap { try? $0.get() }
        let errors = userResult.compactMap { result -> Error? in
            guard case let .failure(error) = result else { return nil }
            return error
        }
        
        return .init(user: user, errors: errors, isLoading: isLoadingSubject.asObservable())
    }
    
    private func user(from input: Input, isLoadingSubject: BehaviorSubject<Bool>) -> Observable<Result<User, Error>> {
        input
            .do(onNext: { isLoadingSubject.onNext(true) })
            .flatMap { gateway.getUser(userId: userId).asObservable() }
            .do(
                onNext: { _ in isLoadingSubject.onNext(false) },
                onError: { _ in isLoadingSubject.onNext(false) }
            )
    }
}
