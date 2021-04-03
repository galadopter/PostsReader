//
//  PostsViewModel.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation
import RxSwift
import RxCocoa

final class PostsViewModel {
    let getPostsUseCase = GetPostsUseCase(gateway: PostsService())
}

extension PostsViewModel: ViewModelType {
    
    typealias Input = Driver<Void>
    
    struct Output {
        let isLoading: Driver<Bool>
        let errors: Signal<Error>
        let posts: Driver<[Post]>
    }
    
    func transform(input: Input) -> Output {
        let output = getPostsUseCase.execute(input: input.asObservable())
        
        return .init(
            isLoading: output.isLoading.asDriver(onErrorJustReturn: false),
            errors: output.errors.asSignal(onErrorJustReturn: EmptyError()),
            posts: output.posts.asDriver(onErrorJustReturn: [])
        )
    }
}
