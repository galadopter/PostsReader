//
//  UsersMapping.swift
//  PostsReaderTests
//
//  Created by Yan Schneider on 4.04.21.
//

import Foundation

extension Address {
    enum CodingKeys: String, CodingKey {
        case street, suite, city, zipcode, location = "geo"
    }
}

extension Geo {
    enum CodingKeys: String, CodingKey {
        case latitude = "lat", longitude = "lng"
    }
}
