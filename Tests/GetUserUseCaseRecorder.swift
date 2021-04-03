//
//  GetUserUseCaseRecorder.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import Nimble
import RxSwift
import RxTest

@testable import PostsReader

class GetUserUseCaseRecorder: Recorder {
    private let useCase: GetUserUseCase
    private let scheduler = TestScheduler(initialClock: 0)
    private let bag = DisposeBag()
    
    lazy var userRecorder: TestableObserver = {
        scheduler.createObserver(User.self)
    }()
    lazy var errorsRecorder: TestableObserver = {
        scheduler.createObserver(Error.self)
    }()
    lazy var isLoadingRecorder: TestableObserver = {
        scheduler.createObserver(Bool.self)
    }()
    
    init(useCase: GetUserUseCase, input: GetUserUseCase.Input) {
        self.useCase = useCase
        let output = useCase.execute(input: input)
        
        bag.insert([
            output.user.bind(to: userRecorder),
            output.errors.bind(to: errorsRecorder),
            output.isLoading.bind(to: isLoadingRecorder)
        ])
    }
    
    func start() {
        scheduler.start()
    }
}
//
