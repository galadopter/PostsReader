//
//  GetUserUseCaseTests.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import XCTest
import RxSwift
import RxTest
import Nimble

@testable import PostsReader

class GetUserUseCaseTests: XCTestCase {

    func testFetchingUser() {
        let user = TestHelperFactory.user()
        let gateway = SuccessMockGetUserGateway(user: user)
        let useCase = GetUserUseCase(userId: 0, gateway: gateway)
        let input = PublishSubject<Void>()
        let recorder = GetUserUseCaseRecorder(useCase: useCase, input: input.asObservable())
        
        recorder.start()
        input.onNext(())
        
        recorder.eventsShouldEmitted(times: 3, recorder: \.isLoadingRecorder)
        recorder.eventsShouldEmitted(times: 1, recorder: \.userRecorder)
        recorder.eventsShouldEmitted(times: 0, recorder: \.errorsRecorder)
        
        recorder.eventElementShouldBe(user, at: 0, for: \.userRecorder)
        recorder.eventElementShouldBe(false, at: 0, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(true, at: 1, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(false, at: 2, for: \.isLoadingRecorder)
    }
    
    func testFailingFetchingUser() {
        let gateway = FailureMockGetUserGateway()
        let useCase = GetUserUseCase(userId: 0, gateway: gateway)
        let input = PublishSubject<Void>()
        let recorder = GetUserUseCaseRecorder(useCase: useCase, input: input.asObservable())
        
        recorder.start()
        input.onNext(())
        
        recorder.eventsShouldEmitted(times: 3, recorder: \.isLoadingRecorder)
        recorder.eventsShouldEmitted(times: 0, recorder: \.userRecorder)
        recorder.eventsShouldEmitted(times: 1, recorder: \.errorsRecorder)
        
        recorder.eventElementShouldBe(false, at: 0, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(true, at: 1, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(false, at: 2, for: \.isLoadingRecorder)
    }
}

private extension GetUserUseCaseTests {
    
    struct SuccessMockGetUserGateway: GetUserGateway {
        let user: User
        
        func getUser(userId: String) -> Single<Result<User, Error>> {
            .just(.success(user))
        }
    }
    
    struct FailureMockGetUserGateway: GetUserGateway {
        
        func getUser(userId: String) -> Single<Result<User, Error>> {
            .just(.failure(TestHelperFactory.error()))
        }
    }
}
