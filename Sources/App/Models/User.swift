//
//  File.swift
//  
//
//  Created by Kevin Earls on 11/04/2023.
//

import Fluent
import Vapor

final class User: Model {
    @ID var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "username") var username: String
    @Children(for: \.$user) var acronyms: [Acronym]

    init() {}

    init(id: UUID? = nil, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }

    static let schema = "users"

}

extension User: Content {}

