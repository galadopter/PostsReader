//
//  TestHelperFactory.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation
@testable import PostsReader

struct TestHelperFactory {
    
    static func posts(
        count: Int = 2
    ) -> [Post] {
        (1...count).map { post(id: $0) }
    }
    
    static func post(
        id: Int = 0,
        userId: Int = 0,
        title: String = "",
        body: String = ""
    ) -> Post {
        .init(
            id: id,
            userId: userId,
            title: title,
            body: body
        )
    }
    
    static func user(
        id: Int = 0,
        name: String = "",
        username: String = "",
        email: String = "",
        address: Address = address(),
        phone: String = "",
        website: String = "",
        company: Company = company()
    ) -> User {
        .init(
            id: id,
            name: name,
            username: username,
            email: email,
            address: address,
            phone: phone,
            website: website,
            company: company
        )
    }
    
    static func address(
        street: String = "",
        suite: String = "",
        city: String = "",
        zipcode: String = "",
        location: Geo = geo()
    ) -> Address {
        .init(
            street: street,
            suite: suite,
            city: city,
            zipcode: zipcode,
            location: location
        )
    }
    
    static func geo(
        latitude: String = "",
        longitude: String = ""
    ) -> Geo {
        .init(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    static func company(
        name: String = "",
        catchPhrase: String = "",
        bs: String = ""
    ) -> Company {
        .init(
            name: name,
            catchPhrase: catchPhrase,
            bs: bs
        )
    }
    
    static func comments(
        count: Int = 2
    ) -> [Comment] {
        (1...count).map { comment(id: $0) }
    }
    
    static func comment(
        id: Int = 0,
        postId: Int = 0,
        name: String = "",
        email: String = "",
        body: String = ""
    ) -> Comment {
        .init(
            id: id,
            postId: postId,
            name: name,
            email: email,
            body: body
        )
    }
    
    static func error(
        message: String = ""
    ) -> Error {
        InternalError(
            message: message
        )
    }
}
