//
//  Models.swift
//  PromisesAndCaching
//
//  Created by Damian Esteban on 2/11/17.
//  Copyright © 2017 Damian Esteban. All rights reserved.
//

import Foundation
import Decodable


struct FullModel {
    let name: String
    let email: String
    let title: String
    let id: Int
    let userId: Int
    let body: String
    let completed: Bool
}

extension FullModel: Decodable {
    static func decode(_ json: Any) throws -> FullModel {
        return try FullModel(
            name: json => "name",
            email: json => "email",
            title: json => "title",
            id: json => "id",
            userId: json => "userId",
            body: json => "body",
            completed: json => "completed"
        )
    }
}
