import Fluent
import Vapor

func routes(_ app: Application) throws {
    let acronymsController = AcronymsController()
    let usersController = UsersController()
    let categoryController = CategoriesController()

    try app.register(collection: acronymsController)
    try app.register(collection: usersController)
    try app.register(collection: categoryController)
}
