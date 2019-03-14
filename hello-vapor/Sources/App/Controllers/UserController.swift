//
//  UserController.swift
//  App
//
//  Created by Mikey  on 29/11/2017.
//

import Vapor
import FluentProvider

final class UserController {
    
    func addRoutes(drop: Droplet) {
        drop.get("users", "all", handler: all)
        drop.get("users", "byId", String.parameter, handler: getByName)
        drop.get("users", "byUsername", String.parameter, handler: getByName)
        drop.get("users", "byType", Int.parameter, handler: getByType)
        drop.post("users", "new", handler: createUser)
        drop.post("users", "updateUserType", handler: updateUserType)
        drop.post("users", "updateEmail", handler: updateEmail)
    }
    
    func all(_ req: Request) throws -> ResponseRepresentable {
        return try JSON(json: User.all().makeJSON())
    }
    
    func getById(_ request: Request) throws -> ResponseRepresentable {
        return try JSON(json: User.makeQuery().filter("id", request.parameters.next(Int.self)).all().makeJSON())
    }
    
    func getByName(_ request: Request) throws -> ResponseRepresentable {
        return try JSON(json: User.makeQuery().filter("username", request.parameters.next(String.self)).all().makeJSON())
    }
    
    func getByType(_ request: Request) throws -> ResponseRepresentable {
        return try JSON(json: User.makeQuery().filter("userType", request.parameters.next(Int.self)).all().makeJSON())
    }
    
    func createUser(_ request: Request) throws -> ResponseRepresentable {
        guard let userName = request.data["username"]?.string,
            let password = request.data["password"]?.string,
            let email = request.data["email"]?.string,
            let userType = request.data["userType"]?.int else {
                throw Abort.badRequest
        }
        
        let user = User(userName: userName, email: email, password: password, userType: userType)
        try user.save()
        return try JSON(json: user.makeJSON())
    }
    
    func updateUserType(_ request: Request) throws -> ResponseRepresentable {
        guard let userId = request.data["userid"]?.int,
        let userType = request.data["usertype"]?.int else {
            throw Abort(.badRequest, reason: "The data suppied does not correspond to the database.")
        }
        guard let user = try User.makeQuery().filter("id", userId).first() else {
            throw Abort(.notFound, reason: "The user id used does not exist in the database.")
        }
        user.userType = (userType)
        try user.save()
        return try JSON(json: user.makeJSON())
        
    }
    
    func updateEmail(_ request: Request) throws -> ResponseRepresentable {
        guard let userId = request.data["userid"]?.int,
            let email = request.data["email"]?.string else {
                throw Abort(.badRequest, reason: "The data suppied does not correspond to the database.")
        }
        guard let user = try User.makeQuery().filter("id", userId).first() else {
            throw Abort(.notFound, reason: "The user id used does not exist in the database.")
        }
        user.email = (email)
        try user.save()
        return try JSON(json: user.makeJSON())
        
    }
    
}
