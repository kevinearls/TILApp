//
//  WebsiteController.swift
//  
//
//  Created by Kevin Earls on 13/04/2023.
//

import Vapor

struct WebsiteController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        routes.get(use: indexHandler)
        routes.get("acronyms", ":acronymID", use: acronymHandler)
    }

    func indexHandler(_ req: Request) throws -> EventLoopFuture<View> {
        Acronym.query(on: req.db).all().flatMap { acronyms in
            let context = IndexContext(title: "Homepage bitches", acronyms: acronyms.isEmpty ? nil : acronyms)
            return req.view.render("index", context)
        }
    }

    func acronymHandler(_ req: Request) throws -> EventLoopFuture<View> {
        Acronym.find(req.parameters.get("acronymID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { acronym in
                acronym.$user.get(on: req.db)
                    .flatMap { user in
                        let context = AcronynmContext(title: "Yo!", acronym: acronym, user: user)
                        return req.view.render("acronym", context)
                    }
            }
    }
}

struct IndexContext: Encodable {
    let title: String
    let acronyms: [Acronym]?
}

struct AcronynmContext: Encodable {
    let title: String
    let acronym: Acronym
    let user: User
}
