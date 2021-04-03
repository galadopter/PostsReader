//
//  GetPostsUseCaseTests.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 3.04.21.
//

import XCTest
import RxSwift
import RxTest
import Nimble

@testable import PostsReader

class GetPostsUseCaseTests: XCTestCase {
    
    func testFetchingPosts() {
        let posts = ModelsFactory.posts()
        let gateway = SuccessMockGetPostsGateway(posts: posts)
        let useCase = GetPostsUseCase(gateway: gateway)
        let input = PublishSubject<Void>()
        let recorder = GetPostsUseCaseRecorder(useCase: useCase, input: input.asObservable())
        
        recorder.start()
        input.onNext(())
        
        recorder.eventsShouldEmitted(times: 3, recorder: \.isLoadingRecorder)
        recorder.eventsShouldEmitted(times: 1, recorder: \.postsRecorder)
        recorder.eventsShouldEmitted(times: 0, recorder: \.errorsRecorder)
        
        recorder.eventElementShouldBe(posts, at: 0, for: \.postsRecorder)
        recorder.eventElementShouldBe(false, at: 0, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(true, at: 1, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(false, at: 2, for: \.isLoadingRecorder)
    }
    
    func testFailingFetchingPosts() {
        let gateway = FailureMockGetPostsGateway()
        let useCase = GetPostsUseCase(gateway: gateway)
        let input = PublishSubject<Void>()
        let recorder = GetPostsUseCaseRecorder(useCase: useCase, input: input.asObservable())
        
        recorder.start()
        input.onNext(())
        
        recorder.eventsShouldEmitted(times: 3, recorder: \.isLoadingRecorder)
        recorder.eventsShouldEmitted(times: 0, recorder: \.postsRecorder)
        recorder.eventsShouldEmitted(times: 1, recorder: \.errorsRecorder)
        
        recorder.eventElementShouldBe(false, at: 0, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(true, at: 1, for: \.isLoadingRecorder)
        recorder.eventElementShouldBe(false, at: 2, for: \.isLoadingRecorder)
        
    }
}

private extension GetPostsUseCaseTests {
    
    struct SuccessMockGetPostsGateway: GetPostsGateway {
        let posts: [Post]
        
        func getPosts() -> Single<Result<[Post], Error>> {
            .just(.success(posts))
        }
    }
    
    struct FailureMockGetPostsGateway: GetPostsGateway {
        
        func getPosts() -> Single<Result<[Post], Error>> {
            .just(.failure(ModelsFactory.error()))
        }
    }
}
