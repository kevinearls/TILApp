import Fluent
import Vapor

func routes(_ app: Application) throws {
    let acronymsController = AcronymsController()
    let usersController = UsersController()
    let categoryController = CategoriesController()
    let websiteController = WebsiteController()

    try app.register(collection: acronymsController)
    try app.register(collection: usersController)
    try app.register(collection: categoryController)
    try app.register(collection: websiteController)
}
