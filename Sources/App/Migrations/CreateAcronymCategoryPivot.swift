//
//  CreateAcronymCategoryPivot.swift
//  
//
//  Created by Kevin Earls on 13/04/2023.
//

import Fluent

struct CreateAcronymCategoryPivot: Migration {
    func revert(on database: FluentKit.Database) -> NIOCore.EventLoopFuture<Void> {
        database.schema("acronym-category-pivot").delete()
    }

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("acronym-category-pivot")
            .id()
            .field("acronymID", .uuid, .required, .references("acronyms", "id", onDelete: .cascade))
            .field("categoryID", .uuid, .required, .references("categories", "id", onDelete: .cascade))
            .create()
    }
}
