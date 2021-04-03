//
//  PostDetailsViewModel.swift
//  PostsReader
//
//  Created by Yan Schneider on 4.04.21.
//

import Foundation
import RxSwift
import RxCocoa

final class PostsDetailsViewModel {
    private let post: Post
    private let getUserUseCase: GetUserUseCase
    
    init(post: Post) {
        self.post = post
        self.getUserUseCase = GetUserUseCase(userId: post.userId, gateway: UsersService())
    }
}

extension PostsDetailsViewModel: ViewModelType {
    
    typealias Input = Driver<Void>
    
    struct Output {
        let isLoading: Driver<Bool>
        let errors: Signal<Error>
        let user: Driver<User>
    }
    
    func transform(input: Input) -> Output {
        let output = getUserUseCase.execute(input: input.asObservable())
        
        return .init(
            isLoading: output.isLoading.asDriver(onErrorJustReturn: false),
            errors: output.errors.asSignal(onErrorJustReturn: EmptyError()),
            user: output.user.asDriver { _ in return .empty() }
        )
    }
}
