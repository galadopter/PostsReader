//
//  GetCommentsUseCaseRecorder.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import Nimble
import RxSwift
import RxTest

@testable import PostsReader

class GetCommentsUseCaseRecorder: Recorder {
    private let useCase: GetCommentsUseCase
    private let scheduler = TestScheduler(initialClock: 0)
    private let bag = DisposeBag()
    
    lazy var commentsRecorder: TestableObserver = {
        scheduler.createObserver([Comment].self)
    }()
    lazy var errorsRecorder: TestableObserver = {
        scheduler.createObserver(Error.self)
    }()
    lazy var isLoadingRecorder: TestableObserver = {
        scheduler.createObserver(Bool.self)
    }()
    
    init(useCase: GetCommentsUseCase, input: GetCommentsUseCase.Input) {
        self.useCase = useCase
        let output = useCase.execute(input: input)
        
        bag.insert([
            output.comments.bind(to: commentsRecorder),
            output.errors.bind(to: errorsRecorder),
            output.isLoading.bind(to: isLoadingRecorder)
        ])
    }
    
    func start() {
        scheduler.start()
    }
}
