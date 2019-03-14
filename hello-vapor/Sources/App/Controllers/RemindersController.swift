//
//  RemindersController.swift
//  App
//
//  Created by Mikey  on 23/11/2017.
//

import Vapor
import FluentProvider

struct RemindersController {
    func addRoutes(to drop: Droplet) {
        let reminderGroup = drop.grouped("api", "reminders")
        reminderGroup.post("create", handler: createReminder)
    }
    func createReminder(_ req: Request) throws -> ResponseRepresentable {
        guard let json = req.json else {
            throw Abort.badRequest
        }
        let reminder = try Reminder(json: json)
        try reminder.save()
        return reminder
    }
}
