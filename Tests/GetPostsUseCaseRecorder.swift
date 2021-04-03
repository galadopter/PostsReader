//
//  GetPostsUseCaseRecorder.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 3.04.21.
//

import Nimble
import RxSwift
import RxTest

@testable import PostsReader

class GetPostsUseCaseRecorder: Recorder {
    private let useCase: GetPostsUseCase
    private let scheduler = TestScheduler(initialClock: 0)
    private let bag = DisposeBag()
    
    lazy var postsRecorder: TestableObserver = {
        scheduler.createObserver([Post].self)
    }()
    lazy var errorsRecorder: TestableObserver = {
        scheduler.createObserver(Error.self)
    }()
    lazy var isLoadingRecorder: TestableObserver = {
        scheduler.createObserver(Bool.self)
    }()
    
    init(useCase: GetPostsUseCase, input: GetPostsUseCase.Input) {
        self.useCase = useCase
        let output = useCase.execute(input: input)
        
        bag.insert([
            output.posts.bind(to: postsRecorder),
            output.errors.bind(to: errorsRecorder),
            output.isLoading.bind(to: isLoadingRecorder)
        ])
    }
    
    func start() {
        scheduler.start()
    }
}
