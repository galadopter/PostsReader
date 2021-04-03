//
//  AppError.swift
//  PostsReader
//
//  Created by Yan on 3/4/21.
//

import Foundation

protocol AppError: Error {
    var message: String { get }
}

struct EmptyError: Error {
    
}

struct InternalError: AppError {
    let message: String
}
