//
//  GetCommentsUseCaseTests.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import XCTest
import RxSwift
import RxTest
import Nimble

@testable import PostsReader

class GetCommentsUseCaseTests: XCTestCase {
    
    func testFetchingPosts() {
        let comments = TestHelperFactory.comments()
        let gateway = SuccessMockGetCommentsGateway(comments: comments)
        let useCase = GetCommentsUseCase(postId: 0, gateway: gateway)
        let input = PublishSubject<Void>()
        let recorder = GetCommentsUseCaseRecorder(useCase: useCase, input: input.asObservable())
        
        recorder.start()
        input.onNext(())
        
        recorder.eventsShouldEmitted(times: 3, recorder: \.isLoadingRecorder)
        recorder.eventsShouldEmitted(times: 1, recorder: \.commentsRecorder)
        recorder.eventsShouldEmitted(times: 0, recorder: \.errorsRecorder)
        
        recorder.eventElementShouldBe(comments, at: 0, for: \.commentsRecorder)
        recorder.eventElementShouldBe(false, at: 0, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(true, at: 1, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(false, at: 2, for: \.isLoadingRecorder)
    }
    
    func testFailingFetchingPosts() {
        let gateway = FailureMockGetCommentsGateway()
        let useCase = GetCommentsUseCase(postId: 0, gateway: gateway)
        let input = PublishSubject<Void>()
        let recorder = GetCommentsUseCaseRecorder(useCase: useCase, input: input.asObservable())
        
        recorder.start()
        input.onNext(())
        
        recorder.eventsShouldEmitted(times: 3, recorder: \.isLoadingRecorder)
        recorder.eventsShouldEmitted(times: 0, recorder: \.commentsRecorder)
        recorder.eventsShouldEmitted(times: 1, recorder: \.errorsRecorder)
        
        recorder.eventElementShouldBe(false, at: 0, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(true, at: 1, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(false, at: 2, for: \.isLoadingRecorder)
    }
}

private extension GetCommentsUseCaseTests {
    
    struct SuccessMockGetCommentsGateway: GetCommentsGateway {
        let comments: [Comment]
        
        func getComments(postId: Int) -> Single<Result<[Comment], Error>> {
            .just(.success(comments))
        }
    }
    
    struct FailureMockGetCommentsGateway: GetCommentsGateway {
        
        func getComments(postId: Int) -> Single<Result<[Comment], Error>> {
            .just(.failure(TestHelperFactory.error()))
        }
    }
}
