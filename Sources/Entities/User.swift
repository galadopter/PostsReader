//
//  User.swift
//  PostsReader
//
//  Created by Yan Schneider on 3.04.21.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct Address: Codable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let location: Geo
}

struct Geo: Codable, Equatable {
    let latitude: String
    let longitude: String
}

struct Company: Codable, Equatable {
    let name: String
    let catchPhrase: String
    let bs: String
}
