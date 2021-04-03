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
    private let getCommentsUseCase: GetCommentsUseCase
    
    init(post: Post) {
        self.post = post
        getUserUseCase = GetUserUseCase(userId: post.userId, gateway: UsersService())
        getCommentsUseCase = GetCommentsUseCase(postId: post.id, gateway: PostsService())
    }
}

extension PostsDetailsViewModel: ViewModelType {
    
    typealias Input = Driver<Void>
    
    struct Output {
        let isLoading: Driver<Bool>
        let errors: Signal<Error>
        let user: Driver<User>
        let comments: Driver<[Comment]>
    }
    
    func transform(input: Input) -> Output {
        let getUserOutput = getUserUseCase.execute(input: input.asObservable())
        let loadingUser = getUserOutput.isLoading.asDriver(onErrorJustReturn: false)
        let loadingUserErrors = getUserOutput.errors.asSignal(onErrorJustReturn: EmptyError())
        
        let getCommentsOutput = getCommentsUseCase.execute(input: input.asObservable())
        let loadingComments = getCommentsOutput.isLoading.asDriver(onErrorJustReturn: false)
        let loadingCommentsErrors = getCommentsOutput.errors.asSignal(onErrorJustReturn: EmptyError())
        
        let isLoading = Driver.combineLatest([loadingUser, loadingComments]).map { $0.allSatisfy { $0 } }
        
        return .init(
            isLoading: isLoading,
            errors: .merge(loadingUserErrors, loadingCommentsErrors),
            user: getUserOutput.user.asDriver { _ in return .empty() },
            comments: getCommentsOutput.comments.asDriver(onErrorJustReturn: [])
        )
    }
}
