//
//  ViewModelType.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import RxCocoa

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

protocol WithErrorsOutput {
    var errors: Signal<Error> { get }
}

protocol WithLoadingOutput {
    var isLoading: Driver<Bool> { get }
}

typealias WithLoadingAndErrors = WithErrorsOutput & WithLoadingOutput
