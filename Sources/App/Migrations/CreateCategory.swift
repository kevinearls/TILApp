//
//  CreateCategory.swift
//  
//
//  Created by Kevin Earls on 11/04/2023.
//

import Fluent

struct CreateCategory: Migration {
    func prepare(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("categories")
            .id()
            .field("name", .string, .required)
            .create()
    }

    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("categories").delete()
    }
}
