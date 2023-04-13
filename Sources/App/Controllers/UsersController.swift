//
//  File.swift
//  
//
//  Created by Kevin Earls on 11/04/2023.
//

import Vapor
struct UsersController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        let userRoutes = routes.grouped("api", "users")
        userRoutes.get(use: getAllHandler)
        userRoutes.post(use: createHandler)
        userRoutes.get(":userID", use: getHandler)
        userRoutes.get(":userID", "acronyms", use: getAcronymsHandler)
    }

    func getAllHandler(_ req: Request) throws -> EventLoopFuture<[User]> {
        User.query(on: req.db).all()
    }

    func createHandler(_ req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req.db)
            .map { user }
    }

    func getHandler(_ req: Request) throws -> EventLoopFuture<User> {
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func getAcronymsHandler(_ req: Request) throws -> EventLoopFuture<[Acronym]> {
        User.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.$acronyms.get(on: req.db)
            }
    }
}
