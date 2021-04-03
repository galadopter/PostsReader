//
//  UseCaseType.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Foundation

protocol UseCaseType {
    associatedtype Input
    associatedtype Output
    
    func execute(input: Input) -> Output
}
