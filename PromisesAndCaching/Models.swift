//
//  Models.swift
//  PromisesAndCaching
//
//  Created by Damian Esteban on 2/11/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import Foundation
import Decodable

struct User: ResponseObject {
    let name: String
    let username: String
    let title: String
    let id: Int
    let userId: Int
    let body: String
    let completed: Bool
}

extension User: Decodable {
    static func decode(_ json: Any) throws -> User {
        return try User(
            name: json => "name",
            username: json => "username",
            title: json => "title",
            id: json => "id",
            userId: json => "userId",
            body: json => "body",
            completed: json => "completed"
        )
    }
}
