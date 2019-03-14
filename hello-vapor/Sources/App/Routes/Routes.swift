import Vapor
import FluentProvider

extension Droplet {
    func setupRoutes() throws {
        
        let userController = UserController()
        userController.addRoutes(drop: self)
        
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        let remindersController = RemindersController()
        remindersController.addRoutes(to: self)
        
        
        post("user", "new") { (request) -> ResponseRepresentable in
            guard let userName = request.data["username"]?.string,
                let password = request.data["password"]?.string,
                let email = request.data["email"]?.string,
                let userType = request.data["userType"]?.int else {
                    throw Abort.badRequest
            }

            let user = User(userName: userName, email: email, password: password, userType: userType)
            try user.save()

            return "Success!\n\nUser Info:\nName: \(user.userName)\nPassword: \(user.password)\nEmail: \(user.email)\nID: \(String(describing: user.id?.wrapped))\nUser Type: \(user.userType)"
        }
        
        get("user", "all") { request in
            return try JSON(json: User.all().makeJSON())
        }
        
        get("user", String.parameter) { request in
            let username = try request.parameters.next(String.self)
            return try JSON(json: User.makeQuery().filter("username", username).all().makeJSON())
        }
        
        get("usertype", Int.parameter) { request in
            let usertype = try request.parameters.next(Int.self)
            return try JSON(json: User.makeQuery().filter("userType", usertype).all().makeJSON())
        }
        
        get("user", "updateemail") { request in
            guard let user = try User.makeQuery().filter("username", request.data["username"]?.string).first() else {
                throw Abort.badRequest
            }
            user.email = (request.data["email"]?.string)!
            try user.save()
            return try JSON(json: user.makeJSON())
        }
        
        get("user", "delete"){ request in
            guard let user = try User.makeQuery().filter("username", request.data["username"]?.string).first() else {
                throw Abort.badRequest
            }
            try user.delete()
            return try JSON(json: User.all().makeJSON())
        }
    }
}
