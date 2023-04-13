//
//  File.swift
//  
//
//  Created by Kevin Earls on 11/04/2023.
//

import Fluent
import Vapor

final class Category: Model {
    @ID var id: UUID?
    @Field(key: "name") var name: String

    init() {}

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }

    static let schema = "categories"

}

extension Category: Content {}
